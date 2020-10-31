using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JETS.Customer
{
    public class Shipping
    {
        public string custFName { get; set; }
        public string custLName { get; set; }
        public string custEmail { get; set; }
        public string custAddress { get; set; }
        public string custPhoneNum { get; set; }

        public Shipping() { }

        public Shipping(string custFName, string custLName, string custEmail, string custAddress, string custPhoneNum) {
            this.custFName = custFName;
            this.custLName = custLName;
            this.custEmail = custEmail;
            this.custAddress = custAddress;
            this.custPhoneNum = custPhoneNum;
        }
    }
}