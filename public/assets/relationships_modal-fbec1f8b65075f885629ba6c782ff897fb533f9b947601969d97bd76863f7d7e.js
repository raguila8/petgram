$(document).ready(function(){var o=$("meta[name=csrf-token]").attr("content");$(".followers-modal-toggle").on("click",function(){var t=$(this).attr("id"),e=parseInt(t.substring(10,t.length));$.ajax({url:"/followers_modal",headers:{Accept:"text/javascript; charset=utf-8","Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"},type:"GET",data:{authenticity_token:o,profile_id:e}})}),$(".following-modal-toggle").on("click",function(){var t=$(this).attr("id"),e=parseInt(t.substring(10,t.length));$.ajax({url:"/following_modal",headers:{Accept:"text/javascript; charset=utf-8","Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"},type:"GET",data:{authenticity_token:o,profile_id:e}})}),$("body").on("click",".followers-modal",function(o){o.stopPropagation()}),$(document).on("click",function(){$(".followers-modal").remove(),$(".following-modal").remove(),$(".page-overlay").css("display","none")}),$(".container").on("click",".modal-dialog .close-btn",function(){$(".following-modal").remove(),$(".followers-modal").remove(),$(".page-overlay").css("display","none")})});