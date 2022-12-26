$(function() {
// パスの取得
  let path = $(location).attr('pathname');
  if ((path == '/books') || (path == '/searches/search')) {
   $('.hidden').show();
  }
});
