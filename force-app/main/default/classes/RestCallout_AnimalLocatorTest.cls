@isTest
private class AnimalLocatorTest {
    @isTest 
    static void animalLocatorMock() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String actual = AnimalLocator.getAnimalNameById(1);
        String expected = 'chicken';
        System.assertEquals(actual, expected,'Animal didn\'t match');
    }
}   