// tab切换
$(function() {
    tabbtn(".icon-left .icon-tab li", ".icon-left .tab-detail");
    tabbtn(".icon-middle .icon-tab li", ".icon-middle .iconm-btn");
    tabbtn(".pr-tab li", ".pr-list");

    function tabbtn(icon01, icon02) {
        $(icon01).each(function() {
            $(this).hover(function() {
                $(icon01).removeClass("current");
                $(this).addClass("current");
                $(icon02).hide();
                $(icon02).eq($(this).index()).show();
            }, function() {

            })
        });
    }
})

// 切换效果
$(function() {
    $(".pro-tab li").each(function() {
        $(this).click(function() {
            var _now = $(this).index();
            $(".pro-tab li").removeClass("current");
            $(this).addClass("current");
            $(".tab-detail").removeClass("tab-show");
            $(".tab-detail").eq(_now).addClass("tab-show");
        })
    })
})

// 收货地址选择
$(function() {
    $(".ship-addr li").each(function() {
        $(this).click(function() {
            $(".ship-addr li").removeClass("current");
            $("input[name='address_id']").val($(this).attr('data'));
            $(this).addClass("current");
        })
    })

    // 购物车全选、选择
    $(".shop-check").each(function() {
        $(this).click(function() {
            if ($(this).hasClass("on-check")) {
                $(this).parent().parent().parent().find(".table-detail .blue-checkbox").addClass("on-check");
                $(this).parent().parent().parent().find(".table-detail input").attr("checked", "checked");
            } else {
                $(this).parent().parent().parent().find(".table-detail .blue-checkbox").removeClass("on-check");
                $(this).parent().parent().parent().find(".table-detail input").attr("checked", false);
            }
        })
    })
    checkall(".cart-head", ".cart-detail");
    checkall(".head-list", ".blue-table");
    checkall(".head-list", ".list-table");

    function checkall(a, b) {
        $(a).find(".checkall").on("click", function() {
            if ($(this).hasClass("on-check")) {
                $(b).find(".blue-checkbox").addClass("on-check");
                $(b).find("input").attr("checked", "checked");
            } else {
                $(b).find(".blue-checkbox").removeClass("on-check");
                $(b).find("input").attr("checked", false);
            }
        })
    }
})

/**
 * +----------------------------------------------------------------------
 * | AJAX相关
 * +----------------------------------------------------------------------
 */
//ajax ajax-form submit表单请求
$('.ajax-submit').click(function() {
    var target, query, form;
    var target_form = $(this).attr('target-form');
    var self = this;
    if (($(self).attr('type') == 'submit') || (target = $(self).attr('href')) || (target = $(self).attr('url'))) {
        form = $('.' + target_form);
        if ($(this).attr('url') !== undefined) {
            target = $(this).attr('url');
        } else {
            target = form.get(0).action;
        }
        query = form.serialize();
        $(self).addClass('disabled').attr('autocomplete', 'off').prop('disabled', true);
        layerPost(target, query, self);
    }
    return false;
});

//ajax ajax-get
$('.ajax-get').click(function() {
    var target;
    var that = this;
    var title = $(this).data('title') ? $(this).data('title') : '进行此操作';
    if ((target = $(that).data('url')) || (target = $(that).attr('href'))) {
        if ($(this).hasClass('confirm')) {
            layer.confirm('确定要' + title + '？', { icon: 0 }, function() {
                layerGet(target);
            });
        } else {
            layerGet(target);
        }
    }
});

/**
 * AJAX layer post方式
 * @method 表单提交方式
 * @target 表单提交地址
 * @query  表单提交地址
 */
function layerPost(url, query, that) {
    $.post(url, query).success(function(data) {
        if (data.status == 1) {
            if (data.url) {
                layer.msg(data.info, { icon: 6, time: 1500 }, function() {
                    window.location.href = data.url;
                });
            } else {
                layer.msg(data.info, { icon: 6, time: 1500 }, function() {
                    $(that).removeClass('disabled').prop('disabled', false);
                    location.reload();
                });
            }
        } else {
            layer.msg(data.info, { icon: 5, time: 1500, shift: 6 }, function() {
                $(that).removeClass('disabled').prop('disabled', false);
            });
        }
    });
}

/**
 * layer ajax get方式
 * @target 表单提交地址
 */
function layerGet(url) {
    $.get(url).success(function(data) {
        if (data.status == 1) {
            if (data.url) {
                layer.msg(data.info, { icon: 6, time: 1500 }, function() {
                    location.href = data.url;
                });
            } else {
                layer.msg(data.info, { icon: 6, time: 1500 }, function() {
                    location.reload();
                })
            }
        } else {
            //layer.msg(data.info, { icon: 5, time: 1500, shift: 6 });
            if (data.url) {
                layer.msg(data.info, { icon: 5, time: 1500 }, function() {
                    location.href = data.url;
                });
            } else {
                layer.msg(data.info, { icon: 5, time: 1500, shift: 6 });
            }
        }
    });
}