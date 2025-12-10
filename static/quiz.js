let currentQuestion = 0;

let questions = document.querySelectorAll('.question');
let nextBtn = document.getElementById('next-btn');
let submitBtn = document.getElementById('submit-btn');
let form = document.getElementById('quiz-form');

function showQuestion(index) {
    for (let i = 0; i < questions.length; i++) {
        if (i === index) {
            questions[i].style.display = "block";
        } else {
            questions[i].style.display = "none";
        }
    }

    if (index === questions.length - 1) {
        nextBtn.style.display = "none";
        submitBtn.style.display = "inline-block";
    } else {
        nextBtn.style.display = "inline-block";
        submitBtn.style.display = "none";
    }
}

nextBtn.addEventListener('click', function() {
    currentQuestion = currentQuestion + 1;
    showQuestion(currentQuestion);
});

form.addEventListener('submit', function(event) {
    event.preventDefault();
    alert("Thank you for your submission!");
});

showQuestion(currentQuestion);
