# create the home controller - use this array structure in order to deploy
home = [
  "$scope"
  "$rootScope"
  "$routeParams"
  "$location"
  "$timeout"
  ($scope,$rootScope,$routeParams,$location,$timeout) -> 
    $scope.Players = new Meteor.AngularCollection "players", $scope, false
    $scope.players = $scope.Players.find {}
    $scope.selected = 0
    $scope.score = '-score'
    $scope.name = '+name'
    $scope.addLove = (play) ->
      play.score = play.score + 5
      play.$save()
    $scope.toggleSelect = (i, player) ->
      $scope.selected = i
      Session.set 'selected', i
      console.log 'selected', i, player
      $scope.edit_player = player
      $scope.save_button_text = 'Edit'
    $scope.sel = (i) ->
      $scope.selected = Session.get('selected')
      if $scope.selected is i then 'selected' else ''
    $scope.edit_player = { name: '', score: 0 }
    $scope.save_player = (player) ->
      console.log player
      if player._id
        player.$save()
        console.log 'update', player
      else
        $scope.Players.insert player
        console.log 'insert', player
      $scope.reset_form()
    $scope.reset_form = () ->
      $scope.edit_player = { name: '', score: 0 }
      $scope.save_button_text = 'Add'
    $scope.reset_form()
]

# create app with home route with pushstate 
angular.module('meteorapp', [])
.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)
  $routeProvider.when '/'
    controller: 'home'
]
