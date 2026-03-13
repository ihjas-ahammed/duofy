import '../models/app_models.dart';

final List<Book> mockBooks = [
  Book(
    id: 'b-physics-1',
    title: 'Modern Physics',
    description: 'Relativity, Quantum Mechanics, and more.',
    icon: 'Atom',
    modules: [
      Module(
        id: 'm-phys-1',
        title: 'Quantum Mechanics',
        description: 'The foundation of the microscopic world.',
        sections: [
          Section(
            id: 's-phys-1-1',
            title: 'Wave-Particle Duality',
            description: 'Light and matter behave as both waves and particles.',
            color: 'duo-blue',
            units: [
              Unit(
                id: 'u-phys-1-1',
                title: 'Photons',
                description: 'The particle nature of light',
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
                        content: 'A photon is a discrete packet of energy associated with electromagnetic radiation.',
                      ),
                      Slide(
                        id: 'sl-2',
                        type: 'quiz',
                        title: 'Check your understanding',
                        content: 'Does a photon have mass?',
                        options: [
                          QuizOption(id: 'a', text: 'Yes', isCorrect: false, explanation: 'Photons are massless particles.'),
                          QuizOption(id: 'b', text: 'No, it has zero rest mass', isCorrect: true, explanation: 'Correct!'),
                        ],
                      ),
                      Slide(
                        id: 'sl-3',
                        type: 'interactive_canvas',
                        title: 'Interactive Wave',
                        content: 'Interact with the wave visualization below.',
                        interactiveCanvasUrl: 'https://phet.colorado.edu/sims/html/wave-interference/latest/wave-interference_en.html',
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
  ),
  Book(
    id: 'b-psych-1',
    title: 'Cognitive Psychology',
    description: 'How the mind works, memory, and perception.',
    icon: 'Brain',
    modules: [
      Module(
        id: 'm-psych-1',
        title: 'Memory Systems',
        description: 'Short term, long term, and working memory.',
        sections: [
          Section(
            id: 's-psych-1-1',
            title: 'Working Memory Model',
            description: 'Baddeley and Hitch',
            color: 'duo-violet',
            units: [
              Unit(
                id: 'u-psych-1-1',
                title: 'Central Executive',
                description: 'The boss of memory',
                lessons: [
                  Lesson(
                    id: 'l-psych-1-1-1',
                    title: 'The Central Executive',
                    description: 'Directing attention',
                    icon: 'BrainCircuit',
                    slides: [
                      Slide(
                        id: 'sl-p-1',
                        type: 'theory',
                        title: 'Role',
                        content: 'The central executive is responsible for monitoring and coordinating the operation of the slave systems (e.g., visuo-spatial sketchpad).',
                      ),
                    ]
                  )
                ]
              )
            ]
          )
        ]
      )
    ]
  ),
];