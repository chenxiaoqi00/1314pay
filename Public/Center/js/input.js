$(function(){
  // radio点击切换
  $(".blue-radio").on("click",function(){
  $(this).addClass("on-radio").siblings().removeClass("on-radio");
  })
  $(".blue-checkbox").on("click",function(){
    $(this).hasClass("on-check")? $(this).removeClass("on-check"):$(this).addClass("on-check");
   //或者这么写
  // $(this).toggleClass( "on_check" );
  })
  $("select").on("change",function(){
    $(this).next(".selectbg").html($(this).find("option:selected").text()); //$(this).find("option:selected").text() 意为获取select选中的值 设置给selectbg
  });

  // 全选
  $(".checkall").on("click",function(){
    if($(this).hasClass("on-check")){
      $(".list-table .blue-checkbox").addClass("on-check");
    }else{
      $(".list-table .blue-checkbox").removeClass("on-check")
    }
  })
})

