/**
 * author gaols
 */
;(function (win, jq) {
    var unipay = {};
    win.unipay = unipay;
    unipay.Monitor = function (payType, outTradeNo, callback, config) {
        this.outTradeNo = outTradeNo;
        this.payType = payType;
        this.callback = callback;
        this.config = jq.extend({maxRepeatTimes: 60, interval: 5}, config);
    };
    unipay.Monitor.prototype.start = function () {
        // repeat interval 5s, max repeat times 60, total 5 minutes.
        var count = 0;
        var _this = this;
        var ajaxTimeout = this.config.interval * 1000;
        var maxRepeatTimes = this.config.maxRepeatTimes;
        var intervalToken = setInterval(function () {
            count++;

            jq.ajax({
                url: unipay.queryOrderStatusPath,
                timeout: ajaxTimeout,
                method: "POST",
                data: {
                    type: _this.payType,
                    outTradeNo: _this.outTradeNo
                }
            }).done(function (data) {
                if (data.paid == "paid") {
                    clearInterval(intervalToken);
                    if (_this.callback.onPaySuccess) {
                        _this.callback.onPaySuccess.call(_this);
                    }
                }
            });

            if (count == maxRepeatTimes) {
                clearInterval(intervalToken);
                if (_this.callback.onPayTimeout) {
                    _this.callback.onPayTimeout.call(_this)
                }
            }
        }, _this.config.interval * 1000);
        _this.intervalToken = intervalToken;
    };

    unipay.Monitor.prototype.stop = function () {
        clearInterval(this.intervalToken);
    };

    /**
     * @param payType wx|alipay
     * @param outTradeNo
     */
    unipay.cancelOrder = function (payType, outTradeNo) {
        jq.ajax({
            url: unipay.cancelPath,
            method: "POST",
            data: {
                type: payType,
                outTradeNo: outTradeNo
            }
        }).done(function (data) {});
    };

    /**
     * you must call this method before any other action.
     * @param config
     */
    unipay.config = function (config) {
        unipay.cancelPath = config.cancelPath;
        unipay.queryOrderStatusPath = config.queryOrderStatusPath;
    }

})(window, jQuery);
