$(function () {
  $(".thumbnails img").click(function () {
    var img = $(this).parents(".photos").find(".big img");
    img.attr("src", $(this).attr("bigimg"));
  });
});