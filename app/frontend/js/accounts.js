document.addEventListener('turbolinks:load', function() {
    let new_account_form_button = document.querySelector('.new_account_button');
    let new_account_form = document.querySelector('.new_account_form');
    new_account_form.style.display = 'none'
    new_account_form_button.addEventListener('click', (e) => {
        e.preventDefault();
        if(new_account_form.style.display === 'none') {
            new_account_form.style.display = ''
        } else {
            new_account_form.style.display = 'none'
        }
    });
})
