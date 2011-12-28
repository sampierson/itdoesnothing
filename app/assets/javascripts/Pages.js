/*
 * This is the page-specific JavaScript framework.
 * It allows you to target JS to only run for one page (specific
 * controller/action) or for all actions for a specific controller.
 *
 * Installation:
 * 
 *   1) Add this file to your loaded scripts.
 *      For Rails 3.1 this probably means just put it in app/assets/javascripts
 *   
 *   2) Put this in an appropriate spot:
 *
 *      YourRootJsClass.Pages = {};
 *
 *      $(document).ready(function() {
 *        Pages.init(YourRootJsClass);
 *      });
 *    
 *   3) Set data-controller_name and data-action_name on your document body, e.g. in HAML:
 *   
 *      %body{ :'data-controller_name' => underscored_controller_name, :'data-action_name' => action_name }
 *   
 *   4) Write controller or page specific JS and watch it get executed:
 *   
 *      YourRootJsClass.Pages = {
 *        ControllernamePages: {                // Note plural class name
 *          init: function() {
 *            // controller specfic JS
 *          }
 *        }
 *        ControllernameActionnamePage: {       // Note singular class name
 *          init: function() {
 *            // page specific JS
 *          }
 *        }
 *      }
 * 
 * How it works:
 *
 *   We uniquely identify pages by putting the Rails controller/action names in
 *   data-controller_name and data-action_name attributes on the HTML body tag.
 *   
 *   At page load time, these names are converted into 2 JavaScript classes, e.g. for controller#action
 *   FooController#bar, the class names YourRootJsClass.Pages.FooPages and YourRootJsClass.FooBarPage are generated.
 *   If either of these classes actually exist, it's init() method is called.
 *   
 *   We store the page specific JS class definitions in app/assets/javascripts/pages.
 *   All files there are automatically included in the page.
 */
Pages = {

  init : function(application) {
    Pages.allPages();
    Pages.pageSpecificInit(application);
  },

  pageSpecificInit: function(application) {
    var controllerName = $('body').attr('data-controller_name');
    var actionName = $('body').attr('data-action_name');

    if (controllerName == undefined) {
      return;
    }

    var controllerClassName = Pages.camelize(controllerName) + 'Pages';
    var pageClassName = Pages.camelize(controllerName) + Pages.camelize(actionName) + 'Page';

    if (application.Pages[controllerClassName]) {
      application.Pages[controllerClassName].init();
    }

    if (application.Pages[pageClassName]) {
      application.Pages[pageClassName].init();
    }
  },

  // Override this function with something that runs the JS you want to run on every page.
  allPages: function() {
  },

  camelize: function(str) {
    var newStr = str.replace(/_(.)/g, function(match, firstChar) {
      return firstChar.toUpperCase();
    });
    return newStr.replace(/^(.)/, function(match, firstChar) {
      return firstChar.toUpperCase();
    });
  }
};
