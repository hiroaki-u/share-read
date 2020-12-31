$(document).on("turbolinks:load", function(){
  //modalの機能
  $(".post-review-button").on("click",function(){
    $(".review-modal").fadeIn();
    return false;
  });
  $(".modal-close").on("click",function(){
    $(".review-modal").fadeOut();
    return false;
  });

  //1200文字以上はボタンが反応しない、入力できない
  $("#review-textarea").on("keydown keyup keypress change", function() {
    if ($(this).val().length > 1200) {
      $(".review-submit-btn").prop("disabled", true);
      $(".review-alert").css('display', 'block')
    } else {
      $(".review-submit-btn").prop("disabled", false);
      $(".review-alert").css('display', 'none')
    }
  });
});