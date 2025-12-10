 let questions = [];
        let currentIndex = 0;
        let answers = {};

        
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
        }

        document.getElementById("next-btn").addEventListener("click", () => {
            const selected = document.querySelector('input[name="answer"]:checked');
            if (!selected) {
                alert("Please select an answer.");
                return;
            }

           
            const questionId = questions[currentIndex].id;
            answers[questionId] = selected.value;

            currentIndex+1;
            showQuestion();
        });

        function submitQuiz() {
            fetch("/submit-quiz", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(answers)
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById("quiz-container").style.display = "none";
                const resultDiv = document.getElementById("result");
                resultDiv.style.display = "block";
                resultDiv.textContent = data.message;
            })
            .catch(err => console.error("Error submitting quiz:", err));
        }