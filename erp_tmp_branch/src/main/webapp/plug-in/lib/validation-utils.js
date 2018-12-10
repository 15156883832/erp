var $validator = {};
(function (o) {
    o.isMobileValid = function (mobile) {
        return /^1\d{10}$/.test(mobile);
    };

    o.isBlank = function (str) {
        return (str == null || str == "") || /^\s+$/.test(str);
    };

    o.isInRange = function (str, minLen, maxLen) {
        return str.length >= minLen && str.length <= maxLen;
    };

    o.isEmailValid = function (email) {
        var re = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        return re.test(email);
    }
})($validator);
