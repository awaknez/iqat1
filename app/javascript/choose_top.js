function display_blocks(){

  // const buttonList = document.querySelectorAll(".button");
  const printQuestionButton = document.getElementById("printQuestionButton");
  const createQuestionButton = document.getElementById("createQuestionButton");
  const printSelectArea = document.getElementById("printSelectArea");
  const chooseArea = document.getElementById("chooseArea");

  const levelSelectArea = document.getElementById("levelSelectArea");
  const levelSelectButton = document.getElementById("levelSelectButton");

  const categorySelectArea = document.getElementById("categorySelectArea");
  const categorySelectButton = document.getElementById("categorySelectButton");

  
  const whatsApp = document.getElementById("whatsApp");
  const applicationOutline = document.getElementById("applicationOutline");

  
  console.log(printSelectArea);
  console.log(chooseArea);

  whatsApp.addEventListener("click",function(e){
    e.preventDefault();

    if (applicationOutline.getAttribute("style") == "display:block;") {
      applicationOutline.removeAttribute("style")
      applicationOutline.setAttribute("style", "display:none;")
    } else {
      // applicationOutlineのstyle属性にdisplay:block;が指定されていない場合（つまり非表示の時）実行される
      applicationOutline.setAttribute("style", "display:block;")
    
    }
  })

  
  createQuestionButton.addEventListener("click",function(e){
    e.preventDefault();

    chooseArea.removeAttribute("style")
    printSelectArea.removeAttribute("style")
    printSelectArea.setAttribute("style","display:none;");

    // if (chooseArea.getAttribute("style") == "display:block;") {

    //   // pullDownParentsのstyle属性にdisplay:block;が指定されている場合（つまり表示されている時）実行される
    //   printSelectArea.removeAttribute("style")
    //   chooseArea.setAttribute("style","display:none;");

    // } else {
    //   // pullDownParentsのstyle属性にdisplay:block;が指定されていない場合（つまり非表示の時）実行される
    //   chooseArea.setAttribute("style", "display:block;")
    // }
  })


  printQuestionButton.addEventListener("click",function(e){
    e.preventDefault();
    console.log(printSelectArea.getAttribute("style"))
    // chooseArea.removeAttribute("style")
    // printSelectArea.setAttribute("style", "display:block;")
    // if (printSelectArea.getAttribute("style") == "display:none;") {

      // pullDownParentsのstyle属性にdisplay:block;が指定されている場合（つまり表示されている時）実行される
      printSelectArea.removeAttribute("style")
      chooseArea.removeAttribute("style")
      chooseArea.setAttribute("style","display:none;");

    // } else {
      // pullDownParentsのstyle属性にdisplay:block;が指定されていない場合（つまり非表示の時）実行される
      // chooseArea.removeAttribute("style")

      // printSelectArea.setAttribute("style", "display:block;")
    // }
  })

  levelSelectButton.addEventListener("click",function(e){
    e.preventDefault();
    console.log(levelSelectArea.getAttribute("style"));

    if (levelSelectArea.getAttribute("style") == "display:block;") {
      levelSelectArea.removeAttribute("style")
      levelSelectArea.setAttribute("style", "display:none;")
    } else {
      // levelSelectAreaのstyle属性にdisplay:block;が指定されていない場合（つまり非表示の時）実行される
      levelSelectArea.setAttribute("style", "display:block;")
    
    }
    console.log(levelSelectArea.getAttribute("style"));

  })

  categorySelectButton.addEventListener("click",function(e){
    e.preventDefault();
    console.log(categorySelectArea.getAttribute("style"));

    if (categorySelectArea.getAttribute("style") == "display:block;") {
      categorySelectArea.removeAttribute("style")
      categorySelectArea.setAttribute("style", "display:none;")
    } else {
      // levelSelectAreaのstyle属性にdisplay:block;が指定されていない場合（つまり非表示の時）実行される
      categorySelectArea.setAttribute("style", "display:block;")
    
    }
    console.log(categorySelectArea.getAttribute("style"));

  })
}

window.addEventListener('load',display_blocks);