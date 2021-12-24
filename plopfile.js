module.exports = function (plop) {
  // controller generator
  plop.setGenerator("controller", {
    description: "application controller logic",
    prompts: [
      {
        type: "input",
        name: "name",
        message: "Controller name:",
      },
    ],
    actions: [],
  });
  plop.setGenerator("screen", {
    description: "application screen",
    prompts: [
      {
        type: "input",
        name: "name",
        message: "Screen name (ex: Hello World):",
      },
    ],
    actions: [
      {
        type: 'add',
        path: 'lib/screens/{{snakeCase name}}/{{snakeCase name}}_screen.dart',
        templateFile: 'templates/screens/default_screen.dart.hbs',
      },
      {
        type: 'add',
        path: 'lib/screens/{{snakeCase name}}/{{snakeCase name}}_screen_controller.dart',
        templateFile: 'templates/screens/default_screen_controller.dart.hbs',
      },
    ],
  });
  plop.setGenerator("dialog", {
    description: "application dialog",
    prompts: [
      {
        type: "input",
        name: "name",
        message: "Dialog name (ex: Hello World):",
      },
    ],
    actions: [
      {
        type: 'add',
        path: 'lib/dialogs/{{snakeCase name}}_dialog.dart',
        templateFile: 'templates/dialogs/dialog1.dart.hbs',
      },
    ],
  });
  plop.setGenerator("drawer", {
    description: "Add application drawer",
    prompts: [],
    actions: [
      {
        type: "add",
        path: "lib/screens/app_drawer.dart",
        templateFile: 'templates/widgets/app_drawer.dart'
      }
    ]
  });
};
