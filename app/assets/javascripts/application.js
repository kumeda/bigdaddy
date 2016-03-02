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
            var selected_city = ""
            if ($scope.selected_city instanceof Object) {
                selected_city = $scope.selected_city.display
            }
            else {
                selected_city = $scope.selected_city
            }

            console.log("http get search_yelp")
            return $http.get('/search_yelp', {
                params: {
                    input: value,
                    location: selected_city
                }
            }).then(function(response){
                console.log(response.data)
                return response.data;
            });
        };

        $scope.getCity = function(value) {
            console.log("http get search_city")
            return $http.get('/search_city', {
                params: { input: value }
            }).then(function(response){
                console.log(response.data)
                return response.data;
            });
        };
    }]);

$(document).on('ready page:load', function(){
    angular.bootstrap(document.body, ['myApp']);
});