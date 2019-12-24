using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using easyUSBHidNetClass;


namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        easyUSBHidNetClass.EasyUSBHidNetClass easyUSBHidNetClass1 = new easyUSBHidNetClass.EasyUSBHidNetClass();
        public Form1()
        {
            InitializeComponent();
            easyUSBHidNetClass1.SerialNumber = "";
            easyUSBHidNetClass1.DeviceUSB_found += EasyUSBHidNetClass1_DeviceUSB_found;
            easyUSBHidNetClass1.DeviceUSB_removed += EasyUSBHidNetClass1_DeviceUSB_removed;
            easyUSBHidNetClass1.anyDeviceUSB_found += EasyUSBHidNetClass1_anyDeviceUSB_found;
            easyUSBHidNetClass1.anyDeviceUSB_removed += EasyUSBHidNetClass1_anyDeviceUSB_removed;
            easyUSBHidNetClass1.DeviceUSB_dataReceived += EasyUSBHidNetClass1_DeviceUSB_dataReceived;
            easyUSBHidNetClass1.DeviceUSB_dataSent += EasyUSBHidNetClass1_DeviceUSB_dataSent;



        }

        //It is necessary to register the App handle
        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            easyUSBHidNetClass1.RegisterHandle(Handle);
        }

        //We will receive OS message  too :)
        protected override void WndProc(ref Message m)
        {
            easyUSBHidNetClass1.USBHidMensagens(ref m);
            base.WndProc(ref m);
        }


        private void EasyUSBHidNetClass1_DeviceUSB_dataSent(object sender, EventArgs e)
        {
            lblStatus.Text = "Hey J3, data sent successfully!";
        }

        private void EasyUSBHidNetClass1_DeviceUSB_dataReceived(object sender, DataRecievedEventArgs args)
        {
            //  InvokeRequired required compares the thread ID of the
            //  calling thread to the thread ID of the creating thread.
            //  If these threads are different, it returns true.  We can
            //  use this attribute to determine if we can append text
            //  directly to the textbox or if we must launch an a delegate
            //  function instance to write to the textbox.

            if (InvokeRequired)
            {
                //  InvokeRequired returned TRUE meaning that this function
                //  was called from a thread different than the current
                //  thread.  We must launch a deleage function.
                //  Invoke the new delegate sending the same Data to the
                //  delegate that was passed into this function from the
                //  other thread.

                Invoke(new DataRecievedEventHandler(EasyUSBHidNetClass1_DeviceUSB_dataReceived), new object[] { sender, args});

            }
            else
            {
                //  If this function was called from the same thread that 
                //  holds the required objects then just add the text.
                ////***********************************
                //Example: 
                // args.data contains the value received on the USB.
                // Buffer PC        Buffer Microcontroller
                if (args.data[19] == 37)
                {
                    //lblValorUSB.Text = args.data[20].ToString();
                }

                if (args.data[0] == 0x37)
                {
                    //lblValorUSB.Text = args.data[1].ToString();
                    //aGauge.Value = (Double)args.data[1]; 
                }
                // args.data[1] <=> writebuff[1]
                // args.data[2] <=> writebuff[2]
                // ...
                // args.data[63] <=> writebuff[63]
                //********
            }
        }

        private void EasyUSBHidNetClass1_anyDeviceUSB_removed(object sender, EventArgs e)
        {
            //InvokeRequired required compares the thread ID of the
            //  calling thread to the thread ID of the creating thread.
            //  If these threads are different, it returns true.  We can
            //  use this attribute to determine if we can append text
            //  directly to the label or if we must launch an a delegate
            //  function instance to write to the label.

            if (InvokeRequired)
            {
                //InvokeRequired returned TRUE meaning that this function
                //  was called from a thread different than the current
                //  thread.  We must launch a deleage function.
                //  Invoke the new delegate sending the same Data to the
                //  delegate that was passed into this function from the
                //  other thread.
                Invoke(new EventHandler(EasyUSBHidNetClass1_anyDeviceUSB_removed), new object[] { sender, e });
            }
            else
            {
                //lblStatus.Text = "Any Device USB HID not found";
            }
        }

        private void EasyUSBHidNetClass1_anyDeviceUSB_found(object sender, EventArgs e)
        {
            //lblStatus.Text = "Any Device USB HID found";
        }

        private void EasyUSBHidNetClass1_DeviceUSB_removed(object sender, EventArgs e)
        {
            lblStatus.Text = "J3 Device USB removed";
        }

        private void EasyUSBHidNetClass1_DeviceUSB_found(object sender, EventArgs e)
        {
            lblStatus.Text = "J3 Device USB found";
        }

        private void Form1_Activated(object sender, EventArgs e)
        {
            easyUSBHidNetClass1.DeviceUSB_Config_VID_PID(0x04d8, 0x003f);
        }
        byte toggle = 0;
        private void button1_Click(object sender, EventArgs e)
        {
            byte[] data = new byte[64];
            data[0] = 10;  //Coringa idetify that the packet is from button1: <coringa><toggle_led>
            toggle ^= 1;
            data[1] = toggle; //xor
            //data[0] = 0x80; 
            WriteUSB(data);    //Send to Microcontroller the USB Buffer 

        }

        byte toggle1 = 0;
        private void button2_Click(object sender, EventArgs e)
        {
            byte[] data = new byte[64];
            data[5] = 10;  //Coringa idetify that the packet is from button2: <coringa><toggle_led> 
            toggle ^= 1;
            data[6] = toggle; //xor
            //data[0] = 0x80; 
            WriteUSB(data);    //Send to Microcontroller the USB Buffer 

        }

        // This function is responsible for sending USB data
        public void WriteUSB(byte[] Data)
        {
            try
            {
                if (easyUSBHidNetClass1.DeviceUsbHID != null)          //Verify USB conection
                {
                    easyUSBHidNetClass1.DeviceUsbHID.writeData(Data);  //reportID and Data -> Send to Microcontroller the USB Writebuffer 

                }
                else
                {
                    // MessageBox.Show("Was not possible to send data!");
                }
            }
            catch (Exception w) //error Exception
            {
                MessageBox.Show(w.ToString()); //show error message
            }

        }

    }
}
