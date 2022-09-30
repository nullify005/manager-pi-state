# manager-pi-state

manages bot base pi systems & also any k8s cluster infrastructure deployed
on top of them

# raspberry pi 3 resource constraints

basically the pi's only have 1GB of RAM & anytime you touch the SD card
the io tanks to hell.

because of this we significantly limit the requests / limits of the pods
and also pull out all the basic prom config & limit it to just the
deployments that I really want metrics collected from

# prometheus snmp exporter

I'm using two mib definitions

* EdgeMax Router ER-X (`helm/values/snmp/mibs/edgemax.yaml`)
* DLink G225 (`helm/values/smnp/mibs/vdsl.yaml`)

With the DLink in particular we're monitoring the VDSL stats collected by
the modem & I wanted to see a plot of it in grafana in order to give
constructive feedback to my NBN provider when the line speed tanks

