$(function(){
  // radio点击切换
  $(".blue-radio").on("click",function(){
    var radioName=$(".blue-radio").find("input").attr("name");
    alert(radioName);
    $(this).addClass("on-radio").siblings().removeClass("on-radio");
    $(".blue-radio").find("input[name= "+ radioName +"]").attr("checked",false);
    $(this).find("input").attr("checked","checked");
  })
  $(".blue-checkbox").on("click",function(){
   if($(this).hasClass("on-check")){
      $(this).removeClass("on-check")
      $(this).find("input").attr("checked",false);
   }else{
      $(this).addClass("on-check");
      $(this).find("input").attr("checked","checked");
   }
  })
  $("select").on("change",function(){
    $(this).next(".selectbg").html($(this).find("option:selected").text()); //$(this).find("option:selected").text() 意为获取select选中的值 设置给selectbg
  });
})