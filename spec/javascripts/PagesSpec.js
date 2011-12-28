DummyApplication = {
  Pages: {
    FooPages: {
      init: function() {}
    },
    FooBarPage: {
      init: function() {}
    }
  }
};

describe("Pages", function() {
  describe(".init", function() {
    it("should call allPages and pass the application class", function() {
      spyOn(Pages, 'allPages');
      spyOn(Pages, 'pageSpecificInit');
      Pages.init(DummyApplication);
      expect(Pages.allPages).toHaveBeenCalledWith();
    });

    it("should call pageSpecificInit", function() {
      spyOn(Pages, 'allPages');
      spyOn(Pages, 'pageSpecificInit');
      Pages.init(DummyApplication);
      expect(Pages.pageSpecificInit).toHaveBeenCalledWith(DummyApplication);
    });
  });

  describe(".pageSpecificInit", function() {
    describe("when body has a controller and action name on it", function() {
      beforeEach(function() {
        $('body').attr('data-controller_name', 'foo');
        $('body').attr('data-action_name', 'bar');
      });

      it("should call the controller specific class when it exists", function() {
        spyOn(DummyApplication.Pages.FooPages, 'init');
        Pages.pageSpecificInit(DummyApplication);
        expect(DummyApplication.Pages.FooPages.init).toHaveBeenCalled();
      });

      it("should call the page specific class when it exists", function() {
        spyOn(DummyApplication.Pages.FooBarPage, 'init');
        Pages.pageSpecificInit(DummyApplication);
        expect(DummyApplication.Pages.FooBarPage.init).toHaveBeenCalled();
      });
    });
  });
});
