let questions = [];
let currentIndex = 0;
let answers = {};

const nextBtn = document.getElementById("next-btn");

fetch('/get-questions')
    .then(response => response.json())
    .then(data => {
        questions = data;
        showQuestion();
    })
    .catch(err => console.error("Error fetching questions:", err));

function showQuestion() {
    if (currentIndex >= questions.length) {
        submitQuiz();
        return;
    }

    const question = questions[currentIndex];
    document.getElementById("question-text").textContent = `${currentIndex + 1}. ${question.question_text}`;

    const optionsDiv = document.getElementById("options");
    optionsDiv.innerHTML = `
        <label><input type="radio" name="answer" value="0"> Strongly Disagree</label><br>
        <label><input type="radio" name="answer" value="1"> Disagree</label><br>
        <label><input type="radio" name="answer" value="2"> Neutral</label><br>
        <label><input type="radio" name="answer" value="3"> Agree</label><br>
        <label><input type="radio" name="answer" value="4"> Strongly Agree</label>
    `;

    if (currentIndex === questions.length - 1) {
        nextBtn.textContent = "Submit";
    } else {
        nextBtn.textContent = "Next";
    }
}


nextBtn.addEventListener("click", () => {
    const selected = document.querySelector('input[name="answer"]:checked');
    if (!selected) {
        alert("Please select an answer.");
        return;
    }

    const questionId = questions[currentIndex].id;
    answers[questionId] = selected.value;

    currentIndex += 1;
    showQuestion();
});


function submitQuiz() {
    
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/submit-quiz';

    
    for (const questionId in answers) {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = questionId;
        input.value = answers[questionId];
        form.appendChild(input);
    }

    document.body.appendChild(form);
    form.submit();  
}

