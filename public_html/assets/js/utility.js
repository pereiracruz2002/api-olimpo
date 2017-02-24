 $("#input-20").fileinput({
    uploadUrl: API+"/foto/upload", // server upload action
    // uploadAsync: true,
    language:'pt-BR',
    maxFileCount: 1,
    showCaption: false,
    showRemove: false,
    showUpload: true,
    // showPreview: false,
    browseClass: "btn-upload",
    browseLabel: "Selecionar Foto",
    uploadLabel: "Enviar",
    uploadClass:"btn-enviar",
    elErrorContainer: "#errorBlock",
    maxFilePreviewSize: '100%',
    uploadExtraData: {
        '_token': $("#token").val(),
        }
    }).on('filebatchpreupload', function(event, data, id, index) {

    }).on('fileuploaded', function(event, data, id, index) {
   
    });