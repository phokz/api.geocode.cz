require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'Malostran 6, Praha' do
    assert_includes Address.ac_test('Malostran 6, Praha'),
                    'Malostranské náměstí 6/18, 11800 Praha - Malá Strana'
  end

  test 'Sokolovská 78, Praha - search both cp and co' do
    results = Address.ac_test 'Sokolovská 78, Praha'
    assert_operator results.size, :>, 1
    assert_includes results, 'Sokolovská 93/78, 18600 Praha - Karlín'
    assert_includes results, 'Sokolovská 78/80, 18600 Praha - Karlín'
  end

  test 'Sokol 30, Brno - search both cp and co, begins with' do
    results = Address.ac_test 'Sokol 30, Brno'
    assert_operator results.size, :>, 1
    assert_includes results, 'Sokolnická 309/11, 62000 Brno - Tuřany'
    assert_includes results, 'Sokolnická 162/30, 62000 Brno - Tuřany'
  end

  test '61900,Sokol 30' do
    results = Address.ac_test '61900,Sokol 30'
    assert_equal 1, results.size
    assert_includes results, 'Sokolova 303/54, 61900 Brno - Horní Heršpice'
  end

  test '61900, Sokol 30' do
    results = Address.ac_test '61900, Sokol 30'
    assert_equal 1, results.size
    assert_includes results, 'Sokolova 303/54, 61900 Brno - Horní Heršpice'
  end

  test '677 Kladno - both evidence normal numbers' do
    results = Address.ac_test '677 Kladno'
    assert_includes results, 'Kročehlavy ev. č. 677, 27201 Kladno'
    assert_includes results, 'Jana Vaita 677, 27204 Kladno - Rozdělov'
  end

  test 'Bruntál 2026/46f' do
    results = Address.ac_test 'Bruntál 2026'
    assert_includes results, 'Zahradní 2026/46f, 79201 Bruntál'
  end
end
