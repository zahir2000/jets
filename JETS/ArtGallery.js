window.onscroll = function (ev) {
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
        document.getElementById("btn-up").style.display = "block";
    } else {
        document.getElementById("btn-up").style.display = "none";
    }
};