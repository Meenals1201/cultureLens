let form = document.getElementById('quiz-form');
let resultsSection = document.getElementById('results-section');
let resultsContainer = document.getElementById('results-container');


form.addEventListener('submit', function(event) {
event.preventDefault();

while (resultsContainer.firstChild) {
resultsContainer.removeChild(resultsContainer.firstChild);
}

let formData = new FormData(form);
let entriesArray = Array.from(formData.entries());


for (let i = 0; i < entriesArray.length; i++) {
let questionName = entriesArray[i][0];
let answerValue = entriesArray[i][1];


let p = document.createElement('p');
p.textContent = questionName + ': ' + answerValue;
resultsContainer.appendChild(p);
}


resultsSection.style.display = 'block';
});