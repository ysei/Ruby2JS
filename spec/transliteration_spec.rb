require  File.dirname( __FILE__ ) + '/spec_helper'

describe RubyToJs do
  
  def rb_parse( string )
    RubyParser.new.parse string
  end
  
  def to_js( string)
    RubyToJs.new( rb_parse( string ) ).to_js
  end
  
  describe 'literals' do
    it "should parse literals and strings" do
      RubyToJs.new( rb_parse( "1" ) ).to_js.should        == '1'
      RubyToJs.new( rb_parse( "'string'" ) ).to_js.should == '"string"'
      RubyToJs.new( rb_parse( ":symbol" ) ).to_js.should  == '"symbol"'
    end
    
    it "should parse simple hash" do
      RubyToJs.new( rb_parse( "{}" ) ).to_js.should            == '{}'
      RubyToJs.new( rb_parse( "{ :a => :b }" ) ).to_js.should  == '{"a" : "b"}'
    end
    
    it "should parse array" do
      RubyToJs.new( rb_parse( "[]" ) ).to_js.should         == '[]'
      RubyToJs.new( rb_parse( "[1, 2, 3]" ) ).to_js.should  == '[1, 2, 3]'
    end
    
    it "should parse nested hash" do
      RubyToJs.new( rb_parse( "{ :a => {:b => :c} }" ) ).to_js.should  == '{"a" : {"b" : "c"}}'
    end
    
    it "should parse array" do
      RubyToJs.new( rb_parse( "[1, [2, 3]]" ) ).to_js.should  == '[1, [2, 3]]'
    end
  end
  
  describe 'assign' do
    it "should parse left assign" do
      RubyToJs.new( rb_parse( "a = 1" ) ).to_js.should        == 'var a = 1'
      RubyToJs.new( rb_parse( "a = 'string'" ) ).to_js.should == 'var a = "string"'
      RubyToJs.new( rb_parse( "a = :symbol" ) ).to_js.should  == 'var a = "symbol"'
    end
    
    it "should not output var if variable is allready declared within a context" do
      RubyToJs.new( rb_parse( "a = 1; a = 2" ) ).to_js.should == 'var a = 1; a = 2'
    end
    
    it "should parse mass assign" do
      RubyToJs.new( rb_parse( "a , b = 1, 2" ) ).to_js.should == 'var a = 1; var b = 2'
    end
  end
  
  describe 'method call' do
    it "should parse method call with no args" do
      RubyToJs.new( rb_parse( "a" ) ).to_js.should == 'a()'
    end
    
    it "should parse method call with args" do
      RubyToJs.new( rb_parse( "a 1, 2, 3" ) ).to_js.should == 'a(1, 2, 3)'
    end
    
    it "should parse lvar as variable call" do
      RubyToJs.new( rb_parse( "a = 1; a" ) ).to_js.should == 'var a = 1; a'
    end
    
    it "should parse square bracket call" do
      RubyToJs.new( rb_parse( "a = [1]; a[0]" ) ).to_js.should == 'var a = [1]; a[0]'
    end
    
    it "should parse nested square bracket call" do
      RubyToJs.new( rb_parse( "a = [[1]]; a[0][0]" ) ).to_js.should == 'var a = [[1]]; a[0][0]'
    end
    
    it "should parse binary operation" do
      RubyToJs.new( rb_parse( "1 + 1" ) ).to_js.should == '1 + 1'
    end
    
    it "should call method on literal" do
      RubyToJs.new( rb_parse( "[0][0]" ) ).to_js.should == '[0][0]'
    end
  end
  
  describe 'boolean' do
    it "should parse boolean" do
      RubyToJs.new( rb_parse( "true; false" ) ).to_js.should    == 'true; false'
    end
    
    it "should parse logic operators" do
      RubyToJs.new( rb_parse( "true && false" ) ).to_js.should  == 'true && false'
      RubyToJs.new( rb_parse( "true and false" ) ).to_js.should == 'true && false'
      RubyToJs.new( rb_parse( "true || false" ) ).to_js.should  == 'true || false'
      RubyToJs.new( rb_parse( "true or false" ) ).to_js.should  == 'true || false'
    end
    
    it "should parse not" do
      RubyToJs.new( rb_parse( "not true" ) ).to_js.should    == '!true'
    end
    
    it "should parse nested logic" do
      to_js( 'not (true or false)' ).should    == '!(true || false)'
    end
    
    it "should parse more complex nested logic" do
      logic = '!((true && false) || (false || false))'
      to_js( logic ).should == logic
    end
    
    it "should parse yet more complex nested logic" do
      logic = '!((true && (false && (true && true))) || (false || false))'
      to_js( logic ).should == logic
    end
  end
  
  describe 'expressions' do
    it "should parse nested expressions" do
      exp = '1 + (1 + 1)'
      to_js( exp ).should == exp
    end
  end
  
end