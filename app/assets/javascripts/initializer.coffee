window.Initializer = do ->
  initialize = ($scope) ->
    initializeDropdown($scope)

  initializeDropdown = ($scope) ->
    $scope.find('.ui.dropdown').dropdown();

  initialize: initialize
