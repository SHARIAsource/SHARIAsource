var $document = $(document)

$document.on('page:change', function() {
  $document.foundation()
  $('select[multiple]').chosen()
  tinymce.init({
    selector: 'textarea.wysiwyg',
    toolbar: 'formatselect styleselect | bold italic underline strikethrough superscript | bullist numlist blockquote | link unlink | image media table | undo redo | ltr rtl',
    plugins: 'image link table paste directionality media',
    style_formats: [{
      title: 'Footnote',
      block: 'p',
      classes: 'ss-footnote'
    }, {
      title: 'Image Right',
      block: 'p',
      classes: 'ss-image-right'
    }, {
      title: 'Image Left',
      block: 'p',
      classes: 'ss-image-left'
    }],
    menubar: false,
    statusbar: false,
    paste_remove_styles: true,
    height: 250,
    content_css: $('meta[name="tinymce-content-css"]').attr('content'),
    image_list: $('meta[name="tinymce-image-list"]').attr('content')
  })
})
