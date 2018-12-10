/**
 * rules = {field-name: {min:{params:xx,msg:xx},required:{}},email:'xx'}，该类依赖于layer.js，请确保在
 * 使用本js之前引入layer.js.
 */
(function($) {
    var commonValidators = {
        isOptional : function(value) {
            return !(this.currentElement.isRequiredF === true)
                && (value == undefined || value == null || value == '')
        },

        required : function(value) {
            value = value || '';
            return value.length > 0;
        },
        // http://jqueryvalidation.org/email-method/
        email : function(value) {
            // https://html.spec.whatwg.org/multipage/forms.html#valid-e-mail-address
            // Retrieved 2014-01-14
            // If you have a problem with this implementation, report a bug
            // against the above spec
            // Or use custom methods to implement your own email validation
            return this.isOptional(value) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test(value);
        },

        // http://jqueryvalidation.org/url-method/
        url : function(value) {

            // Copyright (c) 2010-2013 Diego Perini, MIT licensed
            // https://gist.github.com/dperini/729294
            // see also https://mathiasbynens.be/demo/url-regex
            // modified to allow protocol-relative URLs
            return this.isOptional(value) || /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(value);
        },

        // http://jqueryvalidation.org/date-method/
        date : function(value) {
            return this.isOptional(value) || !/Invalid|NaN/.test(new Date(value).toString());
        },

        // http://jqueryvalidation.org/dateISO-method/
        dateISO : function(value, element) {
            return this.isOptional(value) || /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/.test(value);
        },

        // http://jqueryvalidation.org/number-method/
        number : function(value) {
            return this.isOptional(value) || /^(?:-?\d+|-?\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(value);
        },

        // http://jqueryvalidation.org/digits-method/
        digits : function(value) {
            return this.isOptional(value) || /^\d+$/.test(value);
        },

        // http://jqueryvalidation.org/minlength-method/
        minlength : function(value, param) {
            value = value || '';
            return this.isOptional(value) || value.length >= param;
        },

        // http://jqueryvalidation.org/maxlength-method/
        maxlength : function(value, param) {
            value = value || '';
            return this.isOptional(value) || value.length <= param;
        },

        // http://jqueryvalidation.org/rangelength-method/
        rangelength : function(value, param) {
            return this.isOptional(value) || maxlength(value, param[1]) && minlength(value, param[0]);
        },

        // http://jqueryvalidation.org/min-method/
        min : function(value, param) {
            return this.isOptional(value) || value >= param;
        },

        // http://jqueryvalidation.org/max-method/
        max : function(value, param) {
            return this.isOptional(value) || value <= param;
        },

        // http://jqueryvalidation.org/range-method/
        range : function(value, param) {
            return this.isOptional(value) || (value >= param[0] && value <= param[1]);
        },

        // http://jqueryvalidation.org/equalTo-method/
        equalTo : function(value, param) {
            return this.isOptional(value) || value == param;
        },

        chinese: function(value, param) {
            return this.isOptional(value) || /^[\u4E00-\u9FA5]+$/.test(value);
        },

        unchinese: function(value, param) {
            return this.isOptional(value) || /^[^\u4e00-\u9fa5]+$/.test(value);
        },

        phone: function(value, param) {
            return this.isOptional(value) || /^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/.test(value);
        },

        mobile: function(value, param) {
            return this.isOptional(value) || /^1\d{10}$/.test(value);
        },

        regex: function(value, param) {
            return this.isOptional(value) || param.test(value);
        },

        validate: function (rule, jqElement, isRequired, param, errmsg) {
            if (!this.isValid && this.shortCircuit) {
                return;
            }
            if (typeof errmsg == 'undefined') {
                errmsg = param;
                param = null;
            }
            this.currentElement = jqElement;
            this.currentElement.isRequiredF = isRequired;

            if (!this[rule].call(this, jqElement.val(), param)) {
                this.isValid = false;
                layer.msg(errmsg);
            }
        }
    };

    $._g_validiators = commonValidators;
    commonValidators.isValid = true;
    commonValidators.shortCircuit = false;

	$.fn.validate = function(validationCallback, options) {
		if (typeof (validationCallback) != 'function') {
			options = validationCallback;
			validationCallback = function(validators, msg) {
				layer.msg(msg);
				if ($('body').scrollTop() > this.offset().top) {
					$('html, body').animate({scrollTop: this.offset().top - $('body').offset().top - 10}, 1000);
				}
			};
		}
		var rules = options.rules;

		var getValue = function(element, name) {
			if (element.length > 1) {
				if ($(element[0]).attr('type') == 'radio') {
					return $('[name="' + name + '"]:checked').val();
				}
			}
			return element.val();
		};
		
		var valid = true;
		for (var name in rules) {
			if (!valid) {
				return;
			}
			var validators = rules[name];
			if (validators.fn) {
				if (!valiators.fn.fn.call()) {
					valid = false;
					validationCallback.call(validators, validators.fn.msg);
					break;
				}
			}
			var element = $('[name="' + name + '"]');
			for (var v in validators) {
				var validatorName = v;
				if (validatorName == 'required') {
					element.isRequiredF = true;
				}
				var validator = validators[v];
				var msg = "", params = null;
				if (typeof (validator) == "string") {
					msg = validator;
				} else {
					msg = validator.msg;
					params = validator.params;
				}
				var value = getValue(element, name);
				commonValidators.currentElement = element;
				if (!commonValidators[validatorName].call(commonValidators, value, params)) {
					valid = false;
					validationCallback.call(element, validators, msg);
					break;
				}
			}
		}
		return valid;
	};

}(jQuery));
