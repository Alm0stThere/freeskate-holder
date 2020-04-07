![animation](http://eel.is/freeskate-holder.gif)

# Freeskate Holder

This is a design for a freeline skate holder that:

- is mounted underneath a backpack
- can be operated behind your back without taking off your backpack
- can be operated with a single hand per skate
- confirms successful insertion with a loud click
- uses gravity-assisted ejection
- can be printed with any 3d printer or online 3d print service
- aside from the printed parts only requires two additional laundry peg springs and standard M3 nuts and bolts
- is free and open source
- is made with OpenSCAD

One of the amazing things about freeline skates is their portability.
The main idea of this holder is to leverage that portability and provide an extremely fast way to stash and retrieve a pair of freeline skates
from your backpack.

As of April 2020, printing the holder in standard PLA at 20% infill (which is plenty) with an online 3d print service costs about 50 EUR + shipping.


## Prerequisites

- OpenSCAD
- 2x torsion spring from laundry peg
- 2x 35mm M3 bolt
- 2x M3 nut

## Usage

Do:

    ./build.sh

This will create `frame.stl` and `clip.stl`.

Don't forget to print the clip twice!

## Limitations

For now, the dimensions of the holder are fine-tuned for skates that have the rubber brackets attached to them,
and the holder doesn't work well for skates that don't have the rubber brackets.
Later, I'll add a version of the holder with dimensions fine-tuned for skates that don't have the rubber brackets.