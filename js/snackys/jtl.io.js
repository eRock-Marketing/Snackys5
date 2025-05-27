//IE FIX for IE function calls
function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread(); }

function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _iterableToArray(iter) { if (typeof Symbol !== "undefined" && iter[Symbol.iterator] != null || iter["@@iterator"] != null) return Array.from(iter); }

function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) return _arrayLikeToArray(arr); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }


(function () {
    'use strict';

    var IOClass = function (options) {
        this.init(options);
    };

    IOClass.DEFAULTS = {
        baseUrl: '',
        ioUrl: ''
    };

    IOClass.prototype = {

        constructor: IOClass,

        init: function (options) {
            this.options = $.extend({}, IOClass.DEFAULTS, options);
        },

        call: function (name, params, context, callback) {
            var data = {'name': name, 'params': params};
            this.request(data, context, callback);
        },

        request: function (req, context, callback) {
            var that = this;

            $.evo.trigger('load.io.request', { req: req });

            return $.ajax({
                type: "POST",
                dataType: "json",
                url: this.options.ioUrl,
                data: {'io': JSON.stringify(req)},
                success: function (data, textStatus, jqXHR) {
                    that.handleResponse(data, context);
                    if (typeof callback === 'function') {
                        callback(false, context);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    that.handleError(textStatus, errorThrown);
                    if (typeof callback === 'function') {
                        callback(true, textStatus);
                    }
                },
                complete: function(jqXHR, textStatus) {
                    $.evo.trigger('loaded.io.request', {
                        req: req,
                        status: textStatus
                    });
                }
            });
        },

        handleResponse: function (data, context)
        {
            if(data.domAssigns) {
                data.domAssigns.forEach(function(item){
                    let $item = $('#' + item.target);

                    if ($item.length > 0) {
                        $item[0][item.attr] = item.data;
                    }
                });
            }

            if (!context) {
                context = this;
            }

            if(data.debugLogLines) {
                data.debugLogLines.forEach(function(line){
                    if(line[1]) {
                        console.groupCollapsed(line[0]);
                    }
                    else if(line[2]) {
                        console.groupEnd();
                    }
                    else {
                        console.log(line[0]);
                    }
                });
            }

            if(data.evoProductCalls) {
                data.evoProductCalls.forEach(function(obj){
					//$.evo.article()[name](...args);
					//$.evo.article()[obj[0]](...obj[1]);
					//$.evo.article()[obj[0]].apply(null, obj[1]);
					//eval("$.evo.article()."+obj[0]+"('"+obj[1].join("','")+"');");
					
					//IE11 fixed
					var _$$evo$article;

					(_$$evo$article = $.evo.article())[obj[0]].apply(_$$evo$article, _toConsumableArray(obj[1]));
                });
            }

            if(data.varAssigns) {
                data.varAssigns.forEach(function(assign){
                    context[assign.name] = assign.value;
                });
            }

            if(data.windowLocationHref) {
                window.location.href = data.windowLocationHref;
            }
        },

        handleError: function (textStatus, errorThrown) {
            $.evo.error('handleError', textStatus, errorThrown);
        },

        getFormValues: function (parent) {
            return $('#' + parent).serializeObject();
        },
    };

    // PLUGIN DEFINITION
    // =================

    $.evo.io = function() {
        return new IOClass({
            'ioUrl': $('#jtl-io-path').data('path') + '/io'
        });
    };
})(jQuery);
