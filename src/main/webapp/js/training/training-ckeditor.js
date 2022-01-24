// editor id

// create ck editor
function createCkEditorTraining() {
  var editorIdArray = ["send_content", "training_type2_content",
    "training_type3_content"]
  for (let i = 0; i < editorIdArray.length; i++) {
    CKEDITOR.replace(editorIdArray[i], {
      filebrowserUploadUrl: '/training/image.do?',
      disallowedContent: 'img{width,height}'
    })
  }
}

function createCkEditorTemplate() {
  var editorIdArray = ["send_content", "training_type2_content",
    "training_type3_content"]
  for (let i = 0; i < editorIdArray.length; i++) {
    CKEDITOR.replace(editorIdArray[i], {
      filebrowserUploadUrl: '/template/image.do?',
      disallowedContent: 'img{width,height}'
    })
  }
}

function getCkEditorContent(editorId) {
  return CKEDITOR.instances[editorId].getData();
}

function setCkEditorHtmlContent(editorId, content) {
    CKEDITOR.instances[editorId].insertHtml(content);
  }

function setCkEditorContent(editorId, content) {
  CKEDITOR.instances[editorId].setData(content)
}

function appendCkEditorContent(editorId, content) {
  CKEDITOR.instances[editorId].append
}