describe 'Cocos2d-x (c++) class, property and method autocompletions', ->
  [editor, provider] = []

  getCompletions = ->
    cursor = editor.getLastCursor()
    start = cursor.getBeginningOfCurrentWordBufferPosition()
    end = cursor.getBufferPosition()
    prefix = editor.getTextInRange([start, end])
    request =
      editor: editor
      bufferPosition: end
      scopeDescriptor: cursor.getScopeDescriptor()
      prefix: prefix
    provider.getSuggestions(request)

  beforeEach ->
    waitsForPromise -> atom.packages.activatePackage('autocomplete-cocos2d-x-cpp')
    runs ->
      provider = atom.packages.getActivePackage('autocomplete-cocos2d-x-cpp')
        .mainModule.getProvider()
    waitsFor -> Object.keys(provider.completions).length > 0
    waitsForPromise -> atom.workspace.open('test.cpp')
    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editor.setText('test')
      editor.setCursorBufferPosition([0, Infinity])

  it 'includes the classes of Cocos2d-x (c++)', ->
    expect(getCompletions()).toContain {type:'class', text:'Node'}
    expect(getCompletions()).toContain {type:'class', text:'Sprite'}
    expect(getCompletions()).toContain {type:'class', text:'Label'}
    expect(getCompletions()).toContain {type:'class', text:'LayerColor'}

  it 'includes the properties of Cocos2d-x (c++)', ->
    expect(getCompletions()).toContain {type:'property', text:'ADDITIVE'}
    expect(getCompletions()).toContain {type:'property', text:'ATTRIBUTE_NAME_COLOR'}
    expect(getCompletions()).toContain {type:'property', text:'DEFAULT_MASS'}
    expect(getCompletions()).toContain {type:'property', text:'SHADER_3D_PARTICLE_COLOR'}

  it 'includes the methods of Cocos2d-x (c++)', ->
    expect(getCompletions()).toContain {type:'method', text:'getDistance'}
    expect(getCompletions()).toContain {type:'method', text:'addChild'}
    expect(getCompletions()).toContain {type:'method', text:'removeChild'}
    expect(getCompletions()).toContain {type:'method', text:'getContentSize'}
