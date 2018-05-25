### Script to submit Condor jobs for LHE event generation at UCSD

### Authors:
### Ana Ovcharova
### Dustin Anderson

import os
import sys
import argparse

def submitCondorJob(proc, executable, options, infile, label, outputToTransfer=None, submit=False, proxy="/tmp/x509up_u31156", isGridpackJob=False, maxTime=3600,cpus=1):
    subfile = "condor_"+proc +"_"+label+".cmd"
    f = open(subfile,"w")
    f.write("universe = vanilla\n")
    #f.write("Grid_Resource = condor cmssubmit-r1.t2.ucsd.edu glidein-collector.t2.ucsd.edu\n")
    #f.write("x509userproxy={0}\n".format(proxy))
    #f.write("+DESIRED_Sites=\"T2_US_UCSD\"\n")
    f.write("+MaxRuntime = "+str(maxTime)+"\n")
    if isGridpackJob :
        f.write("RequestCpus = 8\n")
    else:
        if cpus != 1:
            f.write("RequestCpus = %s\n"%cpus)
    f.write("Executable = "+executable+"\n")
    f.write("arguments =  "+(' '.join(options))+"\n")
    f.write("Transfer_Executable = True\n")
    f.write("should_transfer_files = YES\n")
    f.write("transfer_input_files = "+infile+"\n")
    if outputToTransfer is not None:
        f.write("transfer_Output_files = "+outputToTransfer+"\n")
        f.write("WhenToTransferOutput  = ON_EXIT\n")
    f.write("Notification = Never\n")
    f.write("Log=gen_"+proc+"_"+label+".log.$(Cluster).$(Process)\n")
    f.write("output=gen_"+proc+"_"+label+".out.$(Cluster).$(Process)\n")
    f.write("error=gen_"+proc+"_"+label+".err.$(Cluster).$(Process)\n")
    f.write("queue 1\n")
    f.close()

    cmd = "condor_submit "+subfile
    print cmd
    if submit:
        os.system(cmd)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('proc', help="Names of physics model")
    parser.add_argument('--in-file', '-i', dest='infile', help="Full path to input tarball", required=True)
    parser.add_argument('--nevents', '-n', help="Number of events per job", type=int, default=25000)
    parser.add_argument('--njobs', '-j', help="Number of condor jobs", type=int, default=1)
    parser.add_argument('--no-sub', dest='noSub', action='store_true', help='Do not submit jobs')
    parser.add_argument('--proxy', dest="proxy", help="Path to proxy", default='/tmp/x509up_u31156')
    parser.add_argument('--rseed-start', dest='rseedStart', help='Initial value for random seed', 
            type=int, default=500)
    parser.add_argument('--outDir', dest="outDir", help="output directory", default="")
    parser.add_argument('--cpus', dest="cpus", help="cpu requested", default=1)
    parser.add_argument('--time', dest="time", help="Max time for each job in sec", default=3600)
    parser.add_argument('--genproductions-dir', dest='genproductionsDir', help='Path to genproductions repository', default='/home/users/'+os.environ['USER']+'/mcProduction/genproductions')
    args = parser.parse_args()

    proc = args.proc
    nevents = args.nevents
    njobs = args.njobs
    infile_list = [args.infile]
    rseedStart = args.rseedStart
    genproductions_dir = args.genproductionsDir

    infile_list.append(genproductions_dir+'/bin/MadGraph5_aMCatNLO/runcmsgrid_LO.sh')
    infile_list.append(genproductions_dir+'/bin/MadGraph5_aMCatNLO/cleangridmore.sh')
    infile = ','.join(infile_list)

    script_dir = os.path.dirname(os.path.realpath(__file__))
    executable = script_dir+'/runLHEJob.sh'
    out_dir='/hadoop/cms/store/user/'+os.environ['USER']+'/mcProduction/LHE' if not args.outDir else args.outDir
    print "Will generate LHE events using tarball",infile
    
    outdir = out_dir
    options = [proc, str(nevents), outdir]
    print "Options:",(' '.join(options))
    for j in range(0,njobs):
        rseed = str(rseedStart+j)
        print "Random seed",rseed
        submitCondorJob(proc, executable, options+[rseed], infile, label=rseed, submit=(not args.noSub), proxy=args.proxy, maxTime=args.time, cpus=args.cpus)
