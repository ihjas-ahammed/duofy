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
            id: 'pq-mcq-1',
            type: 'quiz',
            title: 'MCQ: Photons',
            content: r'Which of the following describes a photon?',
            options: [
              QuizOption(id: 'a', text: 'A wave of continuous energy.', isCorrect: false, explanation: 'Photons are discrete packets.'),
              QuizOption(id: 'b', text: 'A discrete quantum of electromagnetic energy.', isCorrect: true, explanation: 'Correct!'),
            ]
          ),
          Slide(
            id: 'pq-fib-1',
            type: 'fill_in_blank',
            title: 'Fill in Blank: Energy',
            content: r'The formula for photon energy is \$E = hf\$. If frequency increases, the energy ___ .',
            blankAnswer: 'increases',
          ),
          Slide(
            id: 'pq-num-1',
            type: 'numerical',
            title: 'Numerical: Work Function',
            content: r'If \$E = 5.5\$ eV and \$\Phi = 2.0\$ eV, what is \$K_{max}\$?',
            numericAnswer: 3.5,
            numericTolerance: 0.1,
          ),
          Slide(
            id: 'pq-proof-1',
            type: 'proof',
            title: 'Proof: Length Contraction',
            content: r'Let us formally derive length contraction.',
            interactiveSteps: [
              InteractiveStep(
                stepText: r'Start with the Lorentz transformation: \$x' r"' = \gamma(x - vt)\$"
              ),
              InteractiveStep(
                prompt: r'If we measure the rod in frame S, we measure both ends at the same time \$t\$. What happens to the \$vt\$ term when we calculate \$\Delta x' r"' = x'_2 - x'_1\$?",
                stepText: r'The \$vt\$ term cancels out!',
                options: [
                  QuizOption(id: 'a', text: 'It cancels out.', isCorrect: true, explanation: "Since \$t_1 = t_2\$, \$vt_1 - vt_2 = 0\$."),
                  QuizOption(id: 'b', text: 'It doubles.', isCorrect: false, explanation: 'No, we are subtracting.'),
                ]
              ),
              InteractiveStep(
                stepText: r'Therefore, \$L_0 = \gamma L\$, which rearranges to \$L = L_0/\gamma\$.'
              )
            ]
          ),
          Slide(
            id: 'pq-step-1',
            type: 'step_by_step',
            title: 'Step by Step: Relativity',
            content: r'Calculate the momentum of an electron at \$v=0.8c\$.',
            interactiveSteps: [
              InteractiveStep(
                prompt: 'First, calculate the Lorentz factor \$\\gamma\$.',
                stepText: '\$\\gamma = 1 / \\sqrt{1 - 0.8^2} = 1.667\$',
                options: [
                  QuizOption(id: 'a', text: '1.667', isCorrect: true, explanation: 'Correct!'),
                  QuizOption(id: 'b', text: '0.6', isCorrect: false, explanation: 'That is \$1 - v/c\$.'),
                ]
              ),
              InteractiveStep(
                stepText: 'Now use \$p = \\gamma m v\$ to find the final momentum.'
              )
            ]
          ),
        ],
        examQuestions: [
          Slide(
            id: 'e-1',
            type: 'numerical',
            title: 'Exam: Binding Energy',
            content: r'If the work function \$\Phi\$ is 2.0 eV and incoming light has energy 5.5 eV, what is the max kinetic energy in eV? (\$K_{max} = E - \Phi\$)',
            numericAnswer: 3.5,
            numericTolerance: 0.1,
          ),
          Slide(
            id: 'e-2',
            type: 'quiz',
            title: 'Exam: Ground State',
            content: r'What is the principal quantum number \$n\$ for the ground state of Hydrogen?',
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
                        content: r'A photon is a discrete packet of energy. Max Planck proposed that energy is quantized: \$\$E = hf\$\$ Where \$h\$ is Planck\s constant and \$f\$ is frequency.',
                      ),
                      Slide(
                        id: 'sl-2',
                        type: 'quiz',
                        title: 'Check your understanding',
                        content: r'Does a photon have mass at rest?',
                        options: [
                          QuizOption(id: 'a', text: r'Yes, it is a heavy particle.', isCorrect: false, explanation: r'Photons are massless particles.'),
                          QuizOption(id: 'b', text: r'No, its rest mass is 0.', isCorrect: true, explanation: r'Correct! A photon has no rest mass, but carries momentum \$p = \frac{h}{\lambda}\$.'),
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
                        content: r'Einstein\s photoelectric equation is \$K_{max} = hf - \$ ___, where the missing variable is the work function \$\Phi\$.',
                        blankAnswer: r'\Phi',
                      ),
                      Slide(
                        id: 'sl-5',
                        type: 'numerical',
                        title: 'Calculate Energy',
                        content: r'If \$h \approx 6.62 \times 10^{-34}\$ J·s and \$f = 1 \times 10^{14}\$ Hz, what is E? (Coefficient only)',
                        numericAnswer: 6.62,
                        numericTolerance: 0.1,
                      ),
                      Slide(
                        id: 'sl-proof-1',
                        type: 'proof',
                        title: 'Interactive Derivation',
                        content: 'Let us build the photoelectric equation step by step.',
                        interactiveSteps: [
                          InteractiveStep(
                            stepText: 'Assume a single photon interacts with a single electron.'
                          ),
                          InteractiveStep(
                            prompt: 'What is the energy of the incoming photon?',
                            stepText: 'The photon energy is \$E = hf\$.',
                            options: [
                              QuizOption(id: '1', text: '\$hf\$', isCorrect: true, explanation: 'Planck equation'),
                              QuizOption(id: '2', text: '\$\\Phi\$', isCorrect: false, explanation: 'That is the work function'),
                            ]
                          ),
                          InteractiveStep(
                            stepText: 'Thus, the kinetic energy remaining is \$K_{max} = hf - \\Phi\$.'
                          )
                        ]
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
                        content: r'Electrons orbit the nucleus in specific levels. The energy of the \$n\$-th level in Hydrogen is: \$\$E_n = -\frac{13.6}{n^2} \text{ eV}\$\$',
                      ),
                      Slide(
                        id: 'sl-7',
                        type: 'quiz',
                        title: 'Ground State',
                        content: r'What is the energy of the ground state (\$n=1\$)?',
                        options: [
                          QuizOption(id: 'a', text: r'\$-13.6\$ eV', isCorrect: true, explanation: r'Correct! Plug 1 into the denominator.'),
                          QuizOption(id: 'b', text: r'\$0\$ eV', isCorrect: false, explanation: r'0 eV is when the electron is completely free (\$n=\infty\$).'),
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