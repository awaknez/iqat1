function choose_questions(){
    const buttonList = document.querySelectorAll(".button");
    const genreSelect = document.getElementById("genre_select");

    buttonList.forEach(function(button){
      button.addEventListener("click",function(){
        console.log(button);
        const genreId = button.getAttribute("params");
        

        genreSelect.value = genreId;

      })
    })

}

window.addEventListener('load',choose_questions);