// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
  //= require rails-ujs
  //= require turbolinks
  //= require jquery
  //= require bootstrap-sprockets
  //= require_tree .

$(document).on("turbolinks:load", function(){

  $(".top-images").skippr({
      // スライドショーの変化 ("fade" or "slide")
      transition : 'fade',
      // 変化に係る時間(ミリ秒)
      speed : 1000,
      // easingの種類
      easing : 'easeOutQuart',
      // ナビゲーションの形("block" or "bubble")
      navType : 'block',
      // 子要素の種類("div" or "img")
      childrenElementType : 'div',
      // ナビゲーション矢印の表示(trueで表示)
      arrows : false,
      // スライドショーの自動再生(falseで自動再生なし)
      autoPlay : true,
      // 自動再生時のスライド切替間隔(ミリ秒)
      autoPlayDuration : 4000,
      // キーボードの矢印キーによるスライド送りの設定(trueで有効)
      keyboardOnAlways : true,
      // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
      hidePrevious : false
  });

  $(".top-btn").click(function(){
      $("html, body").animate({"scrollTop":0},300)
  });


  $('#postcode').jpostal({
    postcode : [
      '#postcode'
    ],
    address : {
      '#address' : '%3%4%5'
    }
  });

  $('#select-image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $("#preview-image").attr('src', e.target.result);
  }
    reader.readAsDataURL(e.target.files[0]);
  });

  $('.top-contents').hide().fadeIn(2000);

  $(window).ready(function(){
    $('.recipe-contents .recipe-content').each(function(i){
      $(this).delay(i * 100).css({'visibility':'visible','opacity':'0'}).animate({'opacity': 1 },1000);
    });
  });

  $(window).ready(function(){
    $('.product-contents .product-content').each(function(i){
      $(this).delay(i * 50).css({'visibility':'visible','opacity':'0'}).animate({'opacity': 1 },1000);
    });
  });

})