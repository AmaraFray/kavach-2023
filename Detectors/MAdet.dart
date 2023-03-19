// Uses SMA to detect spikes
// TO: LWMA
const windowSize = 20;
const deltaThresh = 9.3;

class AccelerationDet {
  void Function() x;
  List<double> points = [];

  AccelerationDet(this.x);
  
  
  double computeMA() {
    return points.reduce((a, b) => a + b) / points.length;
  }

  void processPoint(double mag) {
    double delta = mag - computeMA();
    points.add(mag);
    if (points.length > windowSize) {
      points.removeAt(0);
    }
    
    if (delta > 9.3) {
      x();
    }
  }
}


// Util for DJD below
// Encapsulate a window
class JerkWindow {
  List<double> jerkHist = [];
  int size;
  double max = -(1.0 / 0.0); // -infinity in dart ig
 
  JerkWindow(this.size);
  
  void add(double jerk) {
    jerkHist.add(jerk);
    if (jerkHist.length > size) {
      jerkHist.removeAt(0);
    }
    
    if (jerk > max) {
      max = jerk;
    }
  }
  
  void clear() {
    jerkHist.clear();
  }
}
// 25 datapoints, discrete differential, filter max difference in window,
// compute moving average with last 20 max differences
// if this window spike - ma > somelearned threshold
class DiscreteJerkDet {
  var sw = Stopwatch();
  
}
