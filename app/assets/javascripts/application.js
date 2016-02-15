//= require angular
//= require angular-resource
//= require angular-ui-bootstrap-bower
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


angular.module('myApp', [ 'ui.bootstrap' ])
    .controller('MyCtrl', ['$scope', '$http', function($scope, $http) {

        //init
        $scope.selected_city = ''

        $scope.getSpot = function(value) {
            return $http.get('/search_yelp', {
                params: {
                    input: value,
                    location: $scope.selected_city
                }
            }).then(function(response){
                return response.data;
            });
        };

        $scope.getCity = function(value) {
            return $http.get('/search_city', {
                params: { input: value }
            }).then(function(response){
                return response.data;
            });
        };
    }]);

$(document).on('ready page:load', function(){
    angular.bootstrap(document.body, ['myApp']);
});