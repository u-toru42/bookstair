// notification を×で閉じれるように
for (const element of document.querySelectorAll('.notification > .delete')) {
    element.addEventListener('click', e => {
        e.target.parentNode.classList.add('is-hidden');
    });
}