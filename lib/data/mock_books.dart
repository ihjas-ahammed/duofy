import '../models/app_models.dart';

final List<Book> mockBooks = [
  Book(
    id: 'b-physics-1',
    title: 'Modern Physics',
    description: 'Relativity, Quantum Mechanics, and Wave-Particle Duality.',
    icon: 'Atom',
    modules: [
      Module(
        id: 'm-phys-1',
        title: 'Quantum Mechanics',
        description: 'The foundation of the microscopic world.',
        practiceQuestions: [
          Slide(
            id: 'p-1',
            type: 'quiz',
            title: 'Practice: Photons',
            content: r'Which of the following describes a photon?',
            options: [
              QuizOption(id: 'a', text: 'A wave of continuous energy.', isCorrect: false, explanation: 'Photons are discrete packets.'),
              QuizOption(id: 'b', text: 'A discrete quantum of electromagnetic energy.', isCorrect: true, explanation: 'Correct!'),
            ]
          ),
          Slide(
            id: 'p-2',
            type: 'fill_in_blank',
            title: 'Practice: Energy',
            content: r'The formula for photon energy is $E = hf$. If frequency increases, the energy ___ .',
            blankAnswer: 'increases',
          ),
        ],
        examQuestions: [
          Slide(
            id: 'e-1',
            type: 'numerical',
            title: 'Exam: Binding Energy',
            content: r'If the work function $\Phi$ is 2.0 eV and incoming light has energy 5.5 eV, what is the max kinetic energy in eV? ($K_{max} = E - \Phi$)',
            numericAnswer: 3.5,
            numericTolerance: 0.1,
          ),
          Slide(
            id: 'e-2',
            type: 'quiz',
            title: 'Exam: Ground State',
            content: r'What is the principal quantum number $n$ for the ground state of Hydrogen?',
            options: [
              QuizOption(id: 'a', text: '0', isCorrect: false, explanation: 'n starts at 1.'),
              QuizOption(id: 'b', text: '1', isCorrect: true, explanation: 'The lowest energy state is n=1.'),
            ]
          ),
        ],
        sections: [
          Section(
            id: 's-phys-1-1',
            title: 'Section 1: The Quantum Realm',
            description: 'Photons, Waves, and Atoms.',
            color: 'duo-blue',
            units: [
              Unit(
                id: 'u-phys-1-1',
                title: 'Wave-Particle Duality',
                description: 'The Nature of Light',
                lessons: [
                  Lesson(
                    id: 'l-phys-1-1-1',
                    title: 'What is a Photon?',
                    description: 'Basic introduction',
                    icon: 'Sun',
                    slides: [
                      Slide(
                        id: 'sl-1',
                        type: 'theory',
                        title: 'The Photon',
                        content: r'A photon is a discrete packet of energy. Max Planck proposed that energy is quantized: $$E = hf$$ Where $h$ is Planck\s constant and $f$ is frequency.',
                      ),
                      Slide(
                        id: 'sl-2',
                        type: 'quiz',
                        title: 'Check your understanding',
                        content: r'Does a photon have mass at rest?',
                        options: [
                          QuizOption(id: 'a', text: r'Yes, it is a heavy particle.', isCorrect: false, explanation: r'Photons are massless particles.'),
                          QuizOption(id: 'b', text: r'No, its rest mass is 0.', isCorrect: true, explanation: r'Correct! A photon has no rest mass, but carries momentum $p = \frac{h}{\lambda}$.'),
                        ],
                      ),
                      Slide(
                        id: 'sl-3',
                        type: 'interactive_canvas',
                        title: 'Wave Simulation',
                        content: r'Interact with the canvas below to see how sine waves propagate.',
                        interactiveCanvasHtml: r'''
                          <canvas id="myCanvas" style="width:100%; height:100%;"></canvas>
                          <script>
                            const canvas = document.getElementById('myCanvas');
                            const ctx = canvas.getContext('2d');
                            let time = 0;
                            function resize() {
                              canvas.width = canvas.clientWidth;
                              canvas.height = canvas.clientHeight;
                            }
                            window.addEventListener('resize', resize);
                            resize();
                            function draw() {
                              ctx.clearRect(0, 0, canvas.width, canvas.height);
                              ctx.beginPath();
                              ctx.strokeStyle = '#1cb0f6';
                              ctx.lineWidth = 4;
                              for(let i = 0; i < canvas.width; i++) {
                                const y = canvas.height/2 + Math.sin(i * 0.05 + time) * 50;
                                if(i===0) ctx.moveTo(i, y);
                                else ctx.lineTo(i, y);
                              }
                              ctx.stroke();
                              time -= 0.1;
                              requestAnimationFrame(draw);
                            }
                            draw();
                          </script>
                        ''',
                      )
                    ]
                  ),
                  Lesson(
                    id: 'l-phys-1-1-2',
                    title: 'The Photoelectric Effect',
                    description: 'Einstein\'s discovery',
                    icon: 'Camera',
                    slides: [
                      Slide(
                        id: 'sl-4',
                        type: 'fill_in_blank',
                        title: 'Energy Formula',
                        content: r'Einstein\s photoelectric equation is $K_{max} = hf - $ ___, where the missing variable is the work function $\Phi$.',
                        blankAnswer: r'\Phi',
                      ),
                      Slide(
                        id: 'sl-5',
                        type: 'numerical',
                        title: 'Calculate Energy',
                        content: r'If $h \approx 6.62 \times 10^{-34}$ J·s and $f = 1 \times 10^{14}$ Hz, what is E? (Coefficient only)',
                        numericAnswer: 6.62,
                        numericTolerance: 0.1,
                      )
                    ]
                  ),
                ]
              ),
              Unit(
                id: 'u-phys-1-2',
                title: 'The Bohr Model',
                description: 'Atoms and Energy Levels',
                lessons: [
                  Lesson(
                    id: 'l-phys-1-2-1',
                    title: 'Hydrogen Spectrum',
                    description: 'Energy transitions',
                    icon: 'Atom',
                    slides: [
                      Slide(
                        id: 'sl-6',
                        type: 'theory',
                        title: 'Energy Levels',
                        content: r'Electrons orbit the nucleus in specific levels. The energy of the $n$-th level in Hydrogen is: $$E_n = -\frac{13.6}{n^2} \text{ eV}$$',
                      ),
                      Slide(
                        id: 'sl-7',
                        type: 'quiz',
                        title: 'Ground State',
                        content: r'What is the energy of the ground state ($n=1$)?',
                        options: [
                          QuizOption(id: 'a', text: r'$-13.6$ eV', isCorrect: true, explanation: r'Correct! Plug 1 into the denominator.'),
                          QuizOption(id: 'b', text: r'$0$ eV', isCorrect: false, explanation: r'0 eV is when the electron is completely free ($n=\infty$).'),
                        ]
                      )
                    ]
                  )
                ]
              )
            ]
          )
        ]
      )
    ]
  )
];