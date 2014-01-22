// fileupload staff
$(function () {
  // disable dropping to a whole page
  $(document).bind('drop dragover', function (e) {
    e.preventDefault();
  });

  // adding states to drop zone
  // $(document).bind('dragover', function (e) {
  //   var dropZone = $('#dropzone'),
  //   timeout = window.dropZoneTimeout;
  //   if (!timeout) {
  //     dropZone.addClass('in');
  //   } else {
  //     clearTimeout(timeout);
  //   }
  //   var found = false,
  //     node = e.target;
  //   do {
  //     if (node === dropZone[0]) {
  //       found = true;
  //       break;
  //     }
  //     node = node.parentNode;
  //   } while (node != null);
  //   if (found) {
  //     dropZone.addClass('hover');
  //   } else {
  //     dropZone.removeClass('hover');
  //   }
  //   window.dropZoneTimeout = setTimeout(function () {
  //     window.dropZoneTimeout = null;
  //     dropZone.removeClass('in hover');
  //   }, 10);
  // });


  $('#fileupload').fileupload({
    dataType: 'json',
    dropZone: $('#dropzone'),
    acceptFileTypes: /(\.|\/)(png|gif|jpg|jpeg)$/i,
    maxFileSize: 10000000,
    done: function (e, data) {
      $.each(data.result.icon, function (index, file) {
        var link = "<a href='/" + file.url + "' target='_blank'>download</a>";
        $('#result').html(link).hide().fadeIn();
      });
    },
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $('#progress .progress-bar').css(
        'width',
        progress + '%'
      );
    }
  }).on('fileuploadprocessalways', function (e, data) {
    var currentFile = data.files[data.index];
    if (data.files.error && currentFile.error) {
      $('#error').html('Wrong extension').fadeIn();
    }
    else {
      $('#error').fadeOut();
    }
  });
});

