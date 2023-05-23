function insertCopyCodeButtons() {
  const codeBlocks = document.querySelectorAll('div.highlighter-rouge');

  codeBlocks.forEach((codeBlockEle) => {
    const textToCopy = codeBlockEle.innerText;
    const buttonEle = document.createElement('span');
    buttonEle.innerText = 'content_copy';
    buttonEle.classList = 'material-icons absolute top-4 right-4 cursor-pointer hover:text-green-300';

    // handle click event
    buttonEle.onclick = function () {
      window.navigator.clipboard.writeText(textToCopy);
      buttonEle.innerText = 'check';
      buttonEle.classList.add('text-green-300');

      setTimeout(() => {
        // return to pre-copy state
        buttonEle.innerText = 'content_copy';
        buttonEle.classList.remove('text-green-300');
      }, 2000);
    };

    // add the button
    codeBlockEle.appendChild(buttonEle);
  });
}

document.addEventListener('DOMContentLoaded', insertCopyCodeButtons);
