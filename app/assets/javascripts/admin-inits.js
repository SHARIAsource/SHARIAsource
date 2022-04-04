var ready;

ready = function() {
  $(document).foundation()

  $('select[multiple]').select2({
    placeholder: 'Select an option'
  })

  tinymce.init({
    selector: 'textarea.wysiwyg',
    toolbar: 'formatselect styleselect | bold italic underline strikethrough superscript | bullist numlist blockquote | link unlink | image media table | undo redo | ltr rtl | code',
    plugins: 'link image table paste directionality media autosave code',
    browser_spellcheck: true,
    style_formats: [{
      title: 'Footnote',
      block: 'p',
      classes: 'ss-footnote'
    }],
    menubar: false,
    autosave_restore_when_empty: true,
    statusbar: false,
    paste_remove_styles: true,
    height: 250,
    extended_valid_elements : "iframe[src|frameborder|style|scrolling|class|width|height|name|align],script[async|src|charset]",
    content_css: $('meta[name="tinymce-content-css"]').attr('content')
  })

  tinymce.init({
    selector: 'textarea.wysiwyg-summary',
    toolbar: 'italic link unlink | bold italic underline strikethrough superscript | bullist numlist blockquote | image media | undo redo',
    plugins: 'link image media paste autosave',
    browser_spellcheck: true,
    menubar: false,
    autosave_restore_when_empty: true,
    statusbar: false,
    paste_remove_styles: true,
    height: 150,
    content_css: $('meta[name="tinymce-content-css"]').attr('content')
  })
}
$(document).on('page:change', ready);
$(document).on('turbolinks:load', ready);
