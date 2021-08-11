document.addEventListener('DOMContentLoaded', function(){

  const ImageListPreview = document.getElementById('image-list-preview');

  const createImageHTML = (blobpreview) => {
     // 画像を表示するためのdiv要素を生成
     const imageElementPreview = document.createElement('div');

     // 表示する画像を生成
     const blobImagePreview = document.createElement('img');

     blobImagePreview.setAttribute('src', blobpreview);

     imageElementPreview.appendChild(blobImagePreview);
     ImageListPreview.appendChild(imageElementPreview);


  };

  if (!ImageListPreview){ return false;}
  document.getElementById('profile_image_new').addEventListener('change', function(e){

    const imageContentPreview = document.querySelector('img');
      if (imageContentPreview){
        imageContentPreview.remove();
      }
    const filepreview = e.target.files[0];
    const blobpreview = window.URL.createObjectURL(filepreview);

    
     createImageHTML(blobpreview);
  });
});