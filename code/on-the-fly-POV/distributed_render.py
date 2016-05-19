#!/usr/bin/python
import PIL.Image
import numpy
import processing
import os
import sys
import re
import time
import getopt


def open_broken_ppm(fname, true_height):

    chunkfile = None
    try:
        chunkfile = open(fname, "r")
    except Exception, e:
        raise Exception, "Failed to open image chunk"
    
    header = chunkfile.readline()
    if(not re.match("P6",header)):
        raise Exception, "Invalid file format: < %s > for file %s" % (header,fname)
    
    size_header = chunkfile.readline()
    
    m = re.search("(\d+)\s(\d+)", size_header)
    full_size_strings = m.groups();
    width = int(full_size_strings[0])
    height = true_height
    
    levels_header = chunkfile.readline()
    
    data = chunkfile.read()
    #print "size=",len(data)
    #print data
    #print "*********** dims:", width, 'x', height
    pil_im = PIL.Image.fromstring("RGB", (width, height), data)

    return pil_im


def remote_render_part(chunk):

    row_range = chunk["range"]
    povfile = chunk["povfile"]
    povargs = chunk["povargs"]
    remote_dir = chunk["remotedir"]
    username = chunk["username"]
    host = chunk["host"]
    width = chunk["width"]
    height = chunk["height"]
    
    
    startrow = row_range[0]
    endrow = row_range[1]
    tempfilename = "/tmp/tmp%d-%d.ppm" % (startrow, endrow)
    
    povraystring = "/opt/local/bin/povray %s/%s" % (remote_dir, povfile) 
    povraystring += " +W%d +H%d +SR%d +ER%d %s +FP -D -o-" % (width, height, startrow, endrow, povargs)
    
    swallow_stderr = True
    if(swallow_stderr):
        opt_args = " 2>/dev/null"
    else:
        opt_args = ""          

    #os.system("%s 1> %s 2>/dev/null" % (povraystring, tempfilename))
    os.system("ssh %s@%s \"%s\" 1> %s  %s" % (username, host, povraystring, tempfilename, opt_args));
    
    # povray emits corrupt ppm files by default when doing partial renders
    pil_im = open_broken_ppm(tempfilename, endrow-startrow+1)
    
    im = numpy.asarray(pil_im)
    return im


def main():
    
    opts, args = getopt.getopt(sys.argv[1:], [],["user=",
                                                 "host=",
                                                 "n=",
                                                 "remotedir=",
                                                 "povfile=",
                                                 "povargs=",
                                                 "width=",
                                                 "height=",
                                                 "outname="])
    
    # default values
    host = "127.0.0.1"
    username = "labuser"
    remote_dir = ""
    n_processes = 8
    povfile = ""
    povargs = ""
    width = 640
    height = 480
    outname="output.png"
    
    for o,p in opts:
        if o in ['--host']:
            host = p.split(",")
        if o in ['--user']:
            username = p
        if o in ['--n']:
            n_processes = []
            n_processes_strings = p.split(",")
            for s in n_processes_strings:
                n_processes.append(int(s))
        if o in ['--remotedir']:
            remote_dir = p
        if o in ['--povfile']:
            povfile = p
        if o in ['--povargs']:
            povargs = p
        if o in ['--width']:
            width = int(p)
        if o in ['--height']:
            height = int(p)
        if o in ['--outname']:
            outname = p
    
    tic = time.time()

    # put parameter sets into a list of dictionaries
    base_dict = {"host": host[0], 
                 "username":username,
                 "n_processes":n_processes[0],
                 "remotedir":remote_dir,
                 "povfile":povfile,
                 "povargs":povargs,
                 "width":width,
                 "height":height}

    endpoints = range(0, height+1, height/sum(n_processes))
    current_chunk = 0
    chunks = []
    for h in range(0, len(host)):
        
        for p in range(0, n_processes[h]):
            chunk_dict = base_dict.copy()
            chunk_dict["host"] = host[h]
            chunk_dict["range"] = (endpoints[current_chunk]+1, endpoints[current_chunk+1]) 
            chunks.append(chunk_dict)
            current_chunk += 1
    
    pool = processing.Pool(len(chunks))


    # copy the file to the remote host
    #os.system("scp %s %s@%s:%s" % (povfile,username,host,remotedir))
    
    # map the computation into the process pool
    results = pool.map(remote_render_part, chunks)

    # stitch them back together
    finalim = numpy.zeros((height, width, 3), dtype=numpy.uint8)
    for i in range(0,len(results)):
    #    print results[i].shape
        row_range = chunks[i]["range"]
        sr = row_range[0]-1
        er = row_range[1]
        finalim[sr:er, :, :] = results[i]

    pil_finalim = PIL.Image.fromarray(finalim)

    pil_finalim.save(outname)
    print "Render time: ", time.time() - tic 



if __name__ == "__main__":
    main()   