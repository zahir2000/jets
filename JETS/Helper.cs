using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace JETS
{
    public class Helper
    {
        public static string sqlCon = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        public static CultureInfo my = CultureInfo.GetCultureInfo("ms-MY");

        public static int GetOrderID()
        {
            string sql = "SELECT COUNT(*) FROM Orders";
            int orderID = 0;

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();

                try
                {
                    while (dr.Read())
                    {
                        orderID = dr.GetInt32(0) + 1;
                    }
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                    dr.Close();
                }
            }

            return orderID;
        }

        public static int NewOrderNo()
        {

            string num = "0123456789";
            int len = num.Length;
            string newId = String.Empty;
            int newIdRange = 6;
            string digit = String.Empty;
            int index;

            for (int i = 0; i < newIdRange; i++)
            {

                do
                {
                    index = new Random().Next(0, len);
                    digit = num.ToCharArray()[index].ToString();
                } while (newId.IndexOf(digit) != -1);

                newId += digit;
            }

            return Convert.ToInt32(newId);

        }

        public static string ComputeHash(string plainText, byte[] saltBytes)
        {
            if (saltBytes == null)
            {
                int minSaltSize = 4;
                int maxSaltSize = 8;

                Random random = new Random();
                int saltSize = random.Next(minSaltSize, maxSaltSize);

                saltBytes = new byte[saltSize];

                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                rng.GetNonZeroBytes(saltBytes);
            }

            byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

            byte[] plainTextWithSaltBytes = new byte[plainTextBytes.Length + saltBytes.Length];

            for (int i = 0; i < plainTextBytes.Length; i++)
                plainTextWithSaltBytes[i] = plainTextBytes[i];

            for (int i = 0; i < saltBytes.Length; i++)
                plainTextWithSaltBytes[plainTextBytes.Length + i] = saltBytes[i];

            HashAlgorithm hash = new SHA512Managed();

            byte[] hashBytes = hash.ComputeHash(plainTextWithSaltBytes);

            byte[] hashWithSaltBytes = new byte[hashBytes.Length + saltBytes.Length];

            for (int i = 0; i < hashBytes.Length; i++)
                hashWithSaltBytes[i] = hashBytes[i];

            for (int i = 0; i < saltBytes.Length; i++)
                hashWithSaltBytes[hashBytes.Length + i] = saltBytes[i];

            string hashValue = Convert.ToBase64String(hashWithSaltBytes);

            return hashValue;
        }

        public static bool VerifyHash(string plainText, string hashValue)
        {
            byte[] hashWithSaltBytes = Convert.FromBase64String(hashValue);

            int hashSizeInBits = 512, hashSizeInBytes;

            hashSizeInBytes = hashSizeInBits / 8;

            if (hashWithSaltBytes.Length < hashSizeInBytes)
                return false;

            byte[] saltBytes = new byte[hashWithSaltBytes.Length - hashSizeInBytes];

            for (int i = 0; i < saltBytes.Length; i++)
                saltBytes[i] = hashWithSaltBytes[hashSizeInBytes + i];

            string expectedHashString = ComputeHash(plainText, saltBytes);

            return (hashValue == expectedHashString);
        }

    }
}