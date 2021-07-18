document.addEventListener('DOMContentLoaded', function(){
  const ImageList = document.getElementById('image-list');

  const createImageHTML = (blob) => {
    const imageElement = document.createElement("div");
    imageElement.setAttribute('class', "image-element")
    let imageElementNum = document.querySelectorAll('.image-element').length

    const blobImage = document.createElement("img");
    blobImage.setAttribute("src", blob);

    const inputHTML = document.createElement("input")
    inputHTML.setAttribute('id', `class_communication_image_${imageElementNum}`)
    inputHTML.setAttribute('name', 'class_communication[images][]')
    inputHTML.setAttribute('type', 'file')

    imageElement.appendChild(blobImage);
    imageElement.appendChild(inputHTML)
    ImageList.appendChild(imageElement);

    inputHTML.addEventListener('change', (e) => {
      file = e.target.files[0];
      blob = window.URL.createObjectURL(file);

      createImageHTML(blob)
    })
    };

  if (!document.getElementById("profile_image")){ return false;};
  document.getElementById("profile_image").addEventListener("change", function(e){
    //const imageContent = document.querySelector('img');
      //if (imageContent){
        //imageContent.remove();
      //}
    
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    createImageHTML(blob);
  });
  
});