$(document).ready(function(){$('.carousel[data-type="multi"] .item').each(function(){var i=$(this).next();i.length||(i=$(this).siblings(":first")),i.children(":first-child").clone().appendTo($(this));for(var t=0;t<1;t++)(i=i.next()).length||(i=$(this).siblings(":first")),i.children(":first-child").clone().appendTo($(this))})});