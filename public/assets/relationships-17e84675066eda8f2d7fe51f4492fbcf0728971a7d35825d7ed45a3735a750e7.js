$(document).ready(function(){var t=$("meta[name=csrf-token]").attr("content");$("body").on("click",".unfollow-btn",function(e){e.stopImmediatePropagation();var o=$(this).attr("id"),a=parseInt(o.substring(14,o.length));$(".following-btn-"+a).remove(),$.ajax({url:"/unfollow",headers:{Accept:"text/javascript; charset=utf-8","Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"},type:"GET",data:{authenticity_token:t,followed:a}})}),$("body").on("click",".follow-btn",function(e){e.stopImmediatePropagation();var o=$(this).attr("id"),a=parseInt(o.substring(11,o.length));$(".follow-btn-"+a).remove(),$.ajax({url:"/follow",headers:{Accept:"text/javascript; charset=utf-8","Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"},type:"POST",data:{authenticity_token:t,followed:a}})})});