// https://github.com/Quick/Quick

import Quick
import Nimble
import Mirror

struct Person {
  let name: String
  var age: Int
}

class MirrorSpec: QuickSpec {
  override func spec() {
    
    describe("Mirror") {
      let person = Person(name: "Sara", age: 24)
      let mirror = Mirror(person)

      it("can get names") {
        let mirror = Mirror(person)
          expect(mirror.names) == ["name", "age"]
      }
      
      it("can get values") {
        expect(mirror.values.count) == 2
        expect(mirror.values[0] as? String) == "Sara"
        expect(mirror.values[1] as? Int) == 24
      }
      
      it("has a subscript for getting values by name") {
        expect(mirror["name"] as? String) == "Sara"
        expect(mirror["age"] as? Int) == 24
        expect(mirror["NonExist"]).to(beNil())
      }
      
      it("has a get method with generic return type") {
        expect(mirror.get("name")) == "Sara"
        expect(mirror.get("age")) == 24
       
        let nonExit: String? = mirror.get("NonExist")
        expect(nonExit).to(beNil())
      }
      
      it("can be exported to Dictionary") {
        let dic = mirror.toDictionary
        expect(dic.count) == 2
        expect(dic["name"] as? String) == "Sara"
        expect(dic["age"] as? Int) == 24
      }
      
      it("can be exported to NSDictioanry") {
        let dic = mirror.toNSDictionary
        expect(dic.count) == 2
        expect(dic["name"] as? String) == "Sara"
        expect(dic["age"] as? Int) == 24
      }
      
      context("The Collectio type") {
       
        it("has a generator") {
          var generator = mirror.generate()
          var next = generator.next()
          expect(next?.key) == "name"
          
          next = generator.next()
          expect(next?.key) == "age"
          
          expect(generator.next()).to(beNil())
        }
        
        it("has count") {
          expect(count(mirror)) == 2
        }
        it("has int subcript") {
          expect(mirror[0].key) == "name"
          expect(mirror[0].data.value as? String ) == "Sara"
          expect(mirror[1].key) == "age"
          expect(mirror[1].data.value as? Int) == 24
        }
      }
    }
  }
}

/*
      it("can get children mirrors") {
        
        
      }
      
     
      
      it("will eventually fail") {
        expect("time").toEventually( equal("done") )
      }
      
      context("these will pass") {
        
        it("can do maths") {
          expect(23) == 23
        }
        
        it("can read") {
          expect("🐮") == "🐮"
        }
        
        it("will eventually pass") {
          var time = "passing"
          
          dispatch_async(dispatch_get_main_queue()) {
            time = "done"
          }
          
          waitUntil { done in
            NSThread.sleepForTimeInterval(0.5)
            expect(time) == "done"
            
            done()
          }
        }
      }*/
