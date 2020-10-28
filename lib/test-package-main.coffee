TestPackageMainView = require './test-package-main-view'
{CompositeDisposable} = require 'atom'

module.exports = TestPackageMain =
  testPackageMainView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @testPackageMainView = new TestPackageMainView(state.testPackageMainViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @testPackageMainView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'test-package-main:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @testPackageMainView.destroy()

  serialize: ->
    testPackageMainViewState: @testPackageMainView.serialize()

  toggle: ->
    console.log 'TestPackageMain was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
