window.addEventListener('load', function(){

  const pullDownButton = document.getElementById("diary-index");
  const diaryDetail = document.getElementById("diary-detail");
  const diaryIndex = document.querySelectorAll(".diary-index")

  
  pullDownButton.addEventListener('mouseover', function(){
    diaryDetail.setAttribute("style", "display:block;");
  });

  pullDownButton.addEventListener('mouseout', function(){
    diaryDetail.removeAttribute("style", "display:block;")
  });

  

})