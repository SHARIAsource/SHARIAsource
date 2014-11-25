var $document = $(document)

$document.on('page:change', function() {
  $document.foundation()

  $('select[multiple]').chosen()

  tinymce.init({
    selector: 'textarea.wysiwyg',
    toolbar: 'formatselect styleselect | bold italic underline strikethrough superscript | bullist numlist blockquote | link unlink | media table | undo redo | ltr rtl',
    plugins: 'link table paste directionality media',
    style_formats: [{
      title: 'Footnote',
      block: 'p',
      classes: 'ss-footnote'
    }],
    menubar: false,
    statusbar: false,
    paste_remove_styles: true,
    height: 250,
    content_css: $('meta[name="tinymce-content-css"]').attr('content')
  })

  tinymce.init({
    selector: 'textarea.wysiwyg-summary',
    toolbar: 'italic link unlink | undo redo',
    plugins: 'link paste',
    menubar: false,
    statusbar: false,
    paste_remove_styles: true,
    height: 150,
    content_css: $('meta[name="tinymce-content-css"]').attr('content')
  })
})
